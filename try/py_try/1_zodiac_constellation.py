# 序列：字符串 元祖 列表
# 成员操作符 🔗操作符 重复操作符 切片操作符
zodiac_name = ('猴鸡狗猪属牛虎兔龙蛇马羊')
constellation_name = (u'摩羯座', u'水瓶座', u'双鱼座', u'白羊座', u'金牛座', u'双子座',
                      u'巨蟹座', u'狮子座', u'处女座', u'天秤座', u'天蝎座', u'射手座')
# 元祖 不可变更
constellation_days = ((1, 20), (2, 19), (3, 21), (4, 21), (5, 21), (6, 22),
                      (7, 23), (8, 23), (9, 23), (10, 23), (11, 23), (12, 23))
# 元祖比较 元祖嵌套
# 列表 可变更


# filter lambda
# list函数
# len函数

(month, day) = (6, 26)
constellation_day = filter(lambda x: x <= (month, day), constellation_days)
constellation_len = len(list(constellation_day)) % 12
print(constellation_len)
print(constellation_name[constellation_len])
year = int(input('输入年份：'))
size = year % 12
print(zodiac_name[size])

# 列表操作
a_list = ['a', 'ab']
a_list.append('xyz')
print(a_list)
a_list.remove('a')
print(a_list)

# 字典
zodiac_num = {}

zodiac_num = {i: 0 for i in zodiac_name}
# for i in zodiac_name:
#     # 更优雅地赋值
#     zodiac_num[i] = 0

constellation_num = {}

constellation_num = {i: 0 for i in constellation_name}

# for i in constellation_name:
#     constellation_num[i] = 0

while True:
    year = int(input('输入年份：'))
    month = int(input('输入月份：'))
    day = int(input('输入日期：'))
    n = 0
    while constellation_days[n] < (month, day):
        if month == 12 and day > 23:
            break
        n = n + 1
    # print(constellation_name[n])
    zodiac_num[zodiac_name[year % 12]] += 1
    constellation_num[constellation_name[n]] += 1

    for each_key in zodiac_num.keys():
        print('生肖 %s 有 %d 个' % (each_key, zodiac_num[each_key]))

    for each_key in constellation_num.keys():
        print('星座 %s 有 %d 个' % (each_key, constellation_num[each_key]))
