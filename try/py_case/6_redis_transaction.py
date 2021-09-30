import redis
import uuid
import time

pool = redis.ConnectionPool(host="localhost", port=6379, max_connections=1024)
mconn = redis.Redis(connection_pool=pool)
sconn = redis.Redis(connection_pool=pool)
conn = redis.Redis(connection_pool=pool)


# 检查从服务器硬盘写入
def wait_for_sync(mconn, sconn):
    identifier = str(uuid.uuid4())
    # 将令牌添置主服务器
    mconn.zadd('sync:wait', identifier, time.time())
    # 等待服务器完成同步
    while not sconn.info()['master_link_status'] != 'up':
        time.sleep(.001)

    # 等待从服务器接收数据更新
    while not sconn.zscore('sync:wait', identifier):
        time.sleep(.001)

    # 最多等待1秒
    deadline = time.time() + 1.01

    while time.time() < deadline:
        if sconn.info()['aof_pending_bio_fsync'] == 0:
            break
        time.sleep(.001)
    mconn.zrem('sync:wait', identifier)
    mconn.zremrangebyscore('sync:wait', 0, time.time() - 900)


# mysql 关系型数据库 begin commit rollback

# redis 简单事务 multi exec 包裹命令

# 两端提交

# 延迟执行事务 流水响做法 减少客户端与服务器之间的网络通信次数


# watch命令 discard 命令

# 事务失败 watch 之后 exec之前这段时间监视内容发生变化

# 卖方出售游戏商品
def list_item(conn, item_id, seller_id, price):
    inventory = "inventory:%s" % seller_id
    item = "%s.%s" % (item_id, seller_id)
    end = time.time() + 5
    pipe = conn.pipeline()
    while time.time() < end:
        try:
            # 监视用户包裹发生的变化
            pipe.watch(inventory)
            if not pipe.sismember(inventory, item_id):
                pipe.unwatch()
                return None
            pipe.muti()
            # 将被销售的商品添加到商品买卖市场里
            pipe.zadd('market:', item, price)
            # 删除卖方商品库存
            pipe.srem(inventory, item_id)
            pipe.execute()
            return True
        except redis.exceptions.WatchError:
            pass

    return False


# 买方购买游戏商品
def purchase_item(conn, buyer_id, item_id, seller_id, lprice):
    buyer = 'users:%s' % buyer_id
    seller = 'users:%s' % seller_id
    item = "%s.%s" % (item_id, seller_id)
    # 买方装备库
    inventory = "inventory:%s" % buyer_id
    # 10秒重试时间
    end = time.time() + 10
    pipe = conn.pipeline()

    while time.time() < end:
        try:
            # 对商品市场买家信息进行监视
            pipe.watch('market:', buyer)
            price = pipe.zscore('market:', item)
            funds = int(pipe.hget(buyer, 'funds'))
            if price != lprice or price > funds:
                pipe.unwatch()
                return None
            pipe.muti()
            pipe.hincrby(seller, 'funds', int(price))
            pipe.hincrby(buyer, 'funds', int(-price))
            pipe.zrem('market:', item)
            pipe.sadd(inventory, item_id)
            pipe.execute()
            return True
        except redis.exceptions.WatchError:
            pass
    return True

# watch 命令的本质是乐观锁
