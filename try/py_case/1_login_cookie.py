# 登录cookie
import redis
import time

pool = redis.ConnectionPool(host="localhost", port=6379, max_connections=1024)
conn = redis.Redis(connection_pool=pool)


# 散列存储 登录cookie
def check_token(conn, token):
    return conn.hget('login:', token)


# 更新cookie
# 每秒至少可以记录20000件商品
# 比关系型数据库提升100倍
def update_token(conn, token, user, item=None):
    timestamp = time.time()
    conn.hset('login:', token, user)
    conn.zadd('recent:', token, timestamp)
    if item:
        # 令牌最后一次访问商品出现的时间
        conn.zadd('viewed:' + token, item, timestamp)
        # 只保留25条商品浏览过记录
        conn.zremrangebyrank('viewed:' + token, 0, -26)


# 清理session 只保持1000万个会话
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
        #     删除最近浏览的商品记录
        conn.delete(*session_keys)
        # 删除登录的记录
        conn.delete('login:', *tokens)
        # 删除最近登录的记录
        conn.delete('recent:', *tokens)

# 妥善处理500万人次的访问
# 每秒需要清理将近60个令牌
# 网络运行 每秒能清理10000多个
# 本地运行 每秒能清理60000多个
