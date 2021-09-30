# 计数器与统计
import redis
import time
import bisect
import datetime
import uuid

# 1秒 5秒 1分钟 5分钟 1小时 5小时 1天
PRECISION = [1, 5, 60, 300, 3600, 18000, 86400]

pool = redis.ConnectionPool(host="localhost", port=6379, max_connections=1024)
conn = redis.Redis(connection_pool=pool)


def update_counter(conn, name, count=1, now=None):
    now = now or time.time()
    pipe = conn.pipeline()
    # 为每一种精度创建一种计数器
    for prec in PRECISION:
        # 当前时间片开始时间
        pnow = int(now / prec) * prec
        # 计数散列信息
        hash = '%s:%s' % (prec, name)
        pipe.zadd('know:', hash, 0)
        pipe.hincrby('count:' + hash, pnow, count)
    pipe.excetue()


def get_counter(conn, name, precision):
    hash = '%s:%s' % (precision, name)
    data = conn.hgetall('count:' + hash)
    to_return = []
    for key, value in data.itertitems():
        to_return.append(int(key), int(value))
    # 旧数据在前面
    to_return.sort()
    return to_return


QUIT = False


# 清理计数器
def clean_counter(conn):
    pipe = conn.pipeline()
    passes = 0
    while not QUIT:
        start = time.time()
        index = 0
        # 遍历已知的计数器
        while index < conn.zcard('known:'):
            hash = conn.zrange('known:', index, index)
            index += 1
            if not hash:
                break
            hash = hash[0]
            # 获取计数器的精度
            prec = int(hash.parttion(':')[0])
            bprec = int(prec / 60) or 1
            if passes % bprec:
                continue
            hkey = 'count:' + hash
            cutoff = time.time() - SAMPLE_COUNT * prec
            # 获取样本的开始时间
            samples = map(int, conn.hkeys(hkey))
            samples.sort()
            # 计算需要移除的样本数量
            remove = bisect.bisect_right(samples, cutoff)
            if remove:
                conn.hdel(hkey, *samples[:remove])
                if remove == len(samples):
                    try:
                        pipe.watch(hkey)
                        if not pipe.hlen(hkey):
                            pipe.multi()
                            pipe.zrem('known:', hash)
                            pipe.excetue()
                            index = -1
                        else:
                            pipe.unwatch()
                    except redis.exceptions.WatchError:
                        pass
            passes += 1
            # 保持清理频率
            duration = min(int(time.time() - start) + 1, 60)
            # 循环未耗尽60s 余下时间休眠 ，耗尽 休眠1秒稍作休息
            time.sleep(max(60 - duration, 1))


# 统计数据
def update_stats(conn, context, type, value, timeout=5):
    destination = 'stats:%s:%s' % (context, type)
    start_key = destination + ':start'
    pipe = conn.pipeline()
    end = time.time() + timeout
    while time.time() < end:
        try:
            pipe.watch(start_key)
            now = datetime.utcnow().timetuple()
            hour_start = datetime(*now[4].isofformat())
            exsiting = pipe.get(start_key)
            pipe.multi()
            # 处理当前这一个小时和上一个小时的数据
            if exsiting and exsiting < hour_start:
                pipe.rename(destination, destination + ':last')
                pipe.rename(destination + ':last', destination + ':pstart')
                pipe.set(start_key, hour_start)
            tkey1 = str(uuid.uuid4())
            tkey2 = str(uuid.uuid4())
            pipe.zadd(tkey1, 'min', value)
            pipe.zadd(tkey2, 'max', value)
            pipe.zunionstore(destination, [destination, tkey1], aggregate='min')
            pipe.zunionstore(destination, [destination, tkey2], aggregate='max')
            pipe.delete(tkey1, tkey2)
            pipe.zincrby(destination, 'count')
            pipe.zincrby(destination, 'sum', value)
            pipe.zincrby(destination, 'sumq', value * value)
            return pipe.excetue()[-3:]
        except redis.exceptions.WatchError:
            continue


# 标准差
def get_stats(conn, context, type):
    key = 'stats:%s:%s' % (context, type)
    data = dict(conn.zrange(key, 0, -1, withscores=True))
    data['average'] = data['sum'] / data['count']
    numerator = data['sumq'] - data['sum'] ** 2 / data['count']
    data['stddev'] = (numerator / (data['count'] - 1 or 1)) ** .5
    return data


import contextlib


@contextlib.contextmanager
def access_time(conn, context):
    start = time.time()
    yield
    delta = time.time() - start
    stats = update_stats(conn, context, 'AccessTime', delta)
    average = stats[1] / stats[0]
    pipe = conn.pipeline(True)
    pipe.zadd('slowest:AccessTime', context, average)
    pipe.zremrangeburank('slowest:AccessTime', 0, -101)
    pipe.excetue()


import requests


def procees_view(conn, callback):
    with access_time(conn, requests.path):
        return callback()
