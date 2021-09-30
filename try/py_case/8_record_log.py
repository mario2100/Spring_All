# 记录日志
import redis
import time
import logging
import datetime

pool = redis.ConnectionPool(host="localhost", port=6379, max_connections=1024)
conn = redis.Redis(connection_pool=pool)
# dic
SERVERITY = {
    logging.DEBUG: 'debug',
    logging.INFO: 'info',
    logging.WARNING: 'warning',
    logging.ERROR: 'error',
    logging.CRITICAL: 'critical'
}
SERVERITY.update((name, name) for name in SERVERITY.values())


def log_recent(coon, name, message, serverity=logging.INFO, pipe=None):
    serverity = str(SERVERITY.get(serverity, serverity)).lower()
    destination = 'recent:%s:%s' % (name, serverity)
    # 将当前时间记录到消息里
    message = time.asctime() + ' ' + message
    pipe = pipe or conn.pipeline()
    pipe.lpush(destination, message)
    # 对日志列表进行修剪，只包含最新的100条消息
    pipe.ltrim(destination, 0, 99)
    pipe.execute()


# 区分重要的日志消息
# 出现频率为分值
def log_common(conn, name, message, serverity=logging.INFO, timeout=5):
    # 设置日志的安全级别
    serverity = str(SERVERITY.get(serverity, serverity)).lower()
    # 近期常见日志消息的键
    destination = 'common:%s:%s' % (name, serverity)
    start_key = destination + ':start'
    pipe = conn.pipeline()
    end = time.time() + timeout
    while time.time() < end:
        try:
            # 对当前小时数的键进行监视
            pipe.watch(start_key)
            # 当前时间
            now = datetime.utcnow().timetuple()
            # 当前小时数
            hour_start = datetime(*now[:4].isformat())
            # 创建一个事务
            exsiting = pipe.get(start_key)
            pipe.multi()
            # 消息是上一个小时的日志记录
            if exsiting and exsiting < hour_start:
                pipe.rename(destination, destination + ':last')
                pipe.rename(destination + ':last', destination + ':pstart')
                pipe.set(start_key, hour_start)
            elif not exsiting:
                pipe.set(start_key, hour_start)
            pipe.zincrby(destination, message)
            # 常见日志与最新日志 减少通信次数
            log_recent(pipe, name, message, serverity, pipe)
            return
        except redis.exceptions.WatchError:
            continue
