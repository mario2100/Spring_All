# 自定义函数 关键字参数可忽略顺序
# 一个参数 多个参数也可以  可变长参数 None
#
# def func(first, *other):
#     print(first + len(other))
#
#
# func(1, 23, 34)

# 函数变量作用域问题

# var1 = 123
#
#
# def func():
#     # 全局变量
#     global var1
#     var1 = 456
#     print(var1)
#
#
# func()
# print(var1)

# 函数迭代器与生成器
# iter() next()

# list = [1, 2, 3]
# it = iter(list)
# print(next(it))
# print(next(it))
# print(next(it))
# print(next(it))

# 制作迭代器 生成器 range

# def r_range(start, stop, step):
#     x = start
#     while x < stop:
#         # 暂停 并记录位置
#         yield x
#         x += step
#
#
# for i in r_range(1, 10, 0.5):
#     print(i)

# lambda 表达式 简单函数再简化 省略函数名 有返回

# lambda: True

# lambda x, y: x + y

# 使用在何处？

# def func(x):
#     return x <= (month, day)
#
#
# lambda x: x <= (month, day)

# 内置函数 filter map reduce zip

a = [1, 2, 3, 45, 5, 6]

# python3 强制转换成list
print(list(filter(lambda x: x > 2, a)))

# 遍历
b = [4, 5, 6]
print(list(map(lambda x: x + 1, b)))

print(list(map(lambda x, y: x + y, a, b)))

from functools import reduce

# 初始值 1 持续操作
print(reduce(lambda x, y: x + y, [2, 3, 4], 1))

# 合并元祖
print(zip((1, 2, 3), (4, 5, 6)))

for i in zip((1, 2, 3), (4, 5, 6)):
    print(i)
# 字典 key value对调操作
dic_a = {'1': 'a', '2': 'b'}
dic_b = zip(dic_a.values(), dic_a.keys())
print(dic_b)
print(dict(dic_b))
