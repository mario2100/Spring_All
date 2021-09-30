# 非事务流水线
import redis
import time

pool = redis.ConnectionPool(host="localhost", port=6379, max_connections=1024)
conn = redis.Redis(connection_pool=pool)


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


# 非事务流水线执行命令
def update_token_pipeline(conn, token, user, item=None):
    timestamp = time.time()
    pipe = conn.pipeline(False)
    pipe.hset('login:', token, user)
    pipe.zadd('recent:', token, timestamp)
    if item:
        # 令牌最后一次访问商品出现的时间
        pipe.zadd('viewed:' + token, item, timestamp)
        # 只保留25条商品浏览过记录
        pipe.zremrangebyrank('viewed:' + token, 0, -26)
        pipe.zincrby('viewed:', item, -1)
    pipe.excute()


# 测试性能 两个方法每秒执行的次数
def benchmark_update_token(conn, duration):
    for function in (update_token, update_token_pipeline):
        count = 0
        start = time.time()
        end = start + duration
        while time.time() < end:
            count += 1
            function(conn, 'token', 'user', 'item')
            # 函数执行时长
        delta = time.time() - start
        print
        function.__name__, count, delta, count / delta

# 4 5倍性能


# 判断能否被优化
# redis-benchmark -c 1 -q
# 关系型数据库 到 redis 100倍性能  到 非事务线流水线 4-5倍性能
