import redis
import time

pool = redis.ConnectionPool(host="localhost", port=6379, max_connections=1024)
conn = redis.Redis(connection_pool=pool)


# 延迟从20-50ms降低到查询一次redis时间
# 缓存页
def cache_request(conn, request, callback):
    if not can_cache(request):
        return callback(request)
    page_key = 'cache:' + hash_request(request)
    content = conn.get(page_key)

    if not content:
        content = callback(request)
        conn.setex(page_key, content, 300)

    return content
