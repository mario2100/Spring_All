# 系统维护
import redis
import functools

pool = redis.ConnectionPool(host="localhost", port=6379, max_connections=1024)
conn = redis.Redis(connection_pool=pool)

LAST_CHECKED = None
IS_UNDER__MAINTENANCE = False

import time


def is_under_maintenance(conn):
    global LAST_CHECKED, IS_UNDER__MAINTENANCE
    if LAST_CHECKED < time.time() - 1:
        LAST_CHECKED = time.time()
        IS_UNDER__MAINTENANCE = bool(conn.get('is_under_maintenance:'))
    return IS_UNDER__MAINTENANCE


REDIS_CONNECTION = {}


def redis_connection(component, wait=1):
    key = 'config:redis:' + component

    # 包装器接受一个函数作为参数 并使用另一个函数包裹这个函数
    def wrapper(function):
        @functools.wraps(function)
        # 所有位置参数 所有命名参数
        def call(*args, **kwargs):
            old_config = CONFIGS.get(key, object())
            _config = get_config()
