pool = redis.ConnectionPool(host="localhost", port=6379, max_connections=1024)
conn = redis.Redis(connection_pool=pool)


# ip 整数分值
def ip_to_score(ip_address):
    score = 0
    for v in ip_address.split('.'):
        score = score * 256 + int(v, 10)
        return score


import csv


# IP与城市id映射
def import_ips_redis(conn, filename):
    csv_file = csv.reader(open(filename, 'rb'))
    for count, row in enumerate(csv_file):
        start_ip = row[0] if row else ''
        if 'i' in start_ip.lower():
            continue
        if '.' in start_ip:
            start_ip = ip_to_score(start_ip)
        elif start_ip.isdigit():
            start_ip = int(start_ip, 10)
        else:
            continue
        city_id = row[2] + "_" + str(count)
        conn.zadd('ip2cityid:', city_id, start_ip)


import json


# 城市ip导入redis
def import_cities_redis(conn, filename):
    for row in csv.reader(open(filename, 'rb')):
        if len(row) < 4 or not row[0].isdigit():
            continue
        row = [i.decode('latub-1') for i in row]
        city_id = row[0]
        country = row[1]
        region = row[2]
        city = row[3]
        conn.hset('cityid2city:', city_id, json.dump([city, region, country]))


# 查找IP所属城市
def find_city_by_ip(conn, ip_addrees):
    if isinstance(ip_addrees, str):
        ip_addrees = ip_to_score(ip_addrees)
    city_id = conn.zrevrangebyscore('ip2cityid:', ip_addrees, 0, start=0, num=1)
    if not city_id:
        return None
    city_id = city_id[0].partition('_')[0]
    return json.load(conn.hget('cityid2city:', city_id))
