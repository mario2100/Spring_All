# 购物车cookie
import redis
import time

pool = redis.ConnectionPool(host="localhost", port=6379, max_connections=1024)
conn = redis.Redis(connection_pool=pool)


# 加入商品到购物
def add_to_cart(coon, seesion, item, count):
    if count <= 0:
        conn.hrem('cart:' + seesion, item)
    else:
        coon.hset('cart:' + seesion, item, count)


QUIT = False
LIMIT = 10000000


def clean_session():
    while not QUIT:
        # 目前已有的令牌数
        size = conn.zcard('recent:')
        if size <= LIMIT:
            time.sleep(1)
            continue
        end_index = min(size - LIMIT, 100)
        # 获取需要移除的令牌ID
        tokens = conn.zrange('recent:', 0, end_index - 1)

        # 被清理的商品构建键名
        session_keys = []
        for token in tokens:
            session_keys.append('viewed:' + token)
            session_keys.append('cart:' + token)
        # 删除最近浏览的商品和购物车记录
        conn.delete(*session_keys)
        # 删除登录的记录
        conn.delete('login:', *tokens)
        # 删除最近登录的记录
        conn.delete('recent:', *tokens)
