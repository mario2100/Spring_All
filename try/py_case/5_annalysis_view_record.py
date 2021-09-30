import redis
import time
import json

pool = redis.ConnectionPool(host="localhost", port=6379, max_connections=1024)
conn = redis.Redis(connection_pool=pool)


# 流行商品 热点商品

def update_token(conn, token, user, item=None):
    timestamp = time.time()
    conn.hset('login:', token, user)
    conn.zadd('recent:', token, timestamp)
    if item:
        # 令牌最后一次访问商品出现的时间
        conn.zadd('viewed:' + token, item, timestamp)
        # 只保留25条商品浏览过记录
        conn.zremrangebyrank('viewed:' + token, 0, -26)
        # 浏览数
        conn.zincrby('viewed:', item, -1)


QUIT = False


def rescale_viewed(conn):
    while not QUIT:
        # 删除所有排在20000名之后到商品
        conn.zremrangebyrank('', 0, -20001)
        # 将浏览次数降低为原来的一半
        conn.zinterstore('viewed:', {'viewed:': .5})
        time.sleep(300)


# 是否是热点商品继而缓存
def can_cache(conn, request):
    item_id = extract_item_id(request)
    if not item_id or is_dynamic(request):
        return False
    # 排名
    rank = conn.zrank('viewed:', item_id)
    return rank is not None and rank < 10000
