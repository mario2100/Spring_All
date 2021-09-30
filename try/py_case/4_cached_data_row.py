import redis
import time
import json

pool = redis.ConnectionPool(host="localhost", port=6379, max_connections=1024)
conn = redis.Redis(connection_pool=pool)


# 缓存数据行
# 促销活动场景


# 解决每次从数据库中取出特价商品和剩余库存 数据库压力巨大
# 调度
def schedule_row_cache(conn, row_id, delay):
    # 数据行延迟值
    # 缓存行需要每隔几秒更新一次  delay
    conn.zadd('delay:', row_id, delay)
    # 何时缓存到redis里面到时间戳 为分值
    conn.zadd('schedule:', row_id, time.time())


QUIT = False


# 缓存

def cache_row(conn):
    while not QUIT:
        # 获取下一个需要被缓存到数据行以及该行到调度时间戳 返回元祖列表
        next = conn.zrange('schedule:', 0, 0, withscores=True)
        now = time.time()
        if not next or next[0][1] > now:
            time.sleep(.05)
            # 没有行需要被缓存 休眠50毫秒后重试
            continue
        row_id = next[0][0]

        # 获取下一次调度到延迟时间
        delay = conn.zscore('delay:', row_id)
        if delay <= 0:
            conn.zrem('delay:', row_id)
            conn.zrem('schedule:', row_id)
            # 删除行缓存
            conn.delete('inv:' + row_id)
        # 获取数据行
        row = {}
        # row =
        conn.zadd('schedule:', row_id, now + delay)
        conn.set('inv:' + row_id, json.dumps(row.to_dict()))
