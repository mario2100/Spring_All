# if elif else
# for
# while
zodiac_name = ('猴鸡狗猪属牛虎兔龙蛇马羊')
for z in zodiac_name:
    print(z)

# 1-12
for i in range(1, 13):
    print(i)

for year in range(2010, 2021):
    print('%s年是 %s 年' % (year, zodiac_name[year % 12]))
