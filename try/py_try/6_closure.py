# 闭包 也是函数 函数嵌套
#
# def func():
#     a = 1
#     b = 2
#     print(a + b)


#  闭包：外部函数变量被内部函数引用
# def sum(a):
#     def add(b):
#         return a + b
#
#     return add


# add 函数引用
# add() 函数调用


# num1 = func()
# print(type(num1))
#
# num2 = sum(2)
# print(type(num2))
# print(num2(4))


# 实现计数器
# 外部函数
# def counter(start=0):
#     cnt = [start]
#
#     # 内部函数
#     def add_one():
#         cnt[0] += 1
#         return cnt[0]
#
#     return add_one
#
#
# num1 = counter(5)
#
# print(num1())


# 闭包优势作用： 减少函数定义与参数的传入 多条参数变动线
# 闭包更有价值应用：数学计算

# 计算 a*x+b=y

# 外部函数 a+b 内部函数 a*x
# 内涵函数变量x引用到外部函数变量 a b
# def a_line(a, b):
#     def arg_y(x):
#         return a * x + b
#
#     return arg_y
#
#
# line1 = a_line(2, 3)
# print(line1(5))
# line2 = a_line(5, 10)
# print(line2(5))

# lambda 闭包更为优雅
def a_line_lam(a, b):
    return lambda x: a * x + b
