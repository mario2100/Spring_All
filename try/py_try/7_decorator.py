# # 函数高阶功能 ：函数装饰器 凸显主角光环 闭包升级 函数切面
#
# import time
#
#
# # print(time.time())
#
#
# def timer(func):
#     def wrapper():
#         start_time = time.time()
#         func()
#         stop_time = time.time()
#         print(stop_time - start_time)
#
#     return wrapper
#
#
# # 语法糖
# @timer
# def i_can_sleep():
#     time.sleep(3)
#
#
# i_can_sleep()


# 带参数的装饰器 修饰函数

def tips(func):
    def inside(a, b):
        print('start')
        func(a, b)
        print('stop')

    return inside


@tips
def add(a, b):
    print(a + b)


print(add(4, 5))


# 装饰器参数 ：针对不同函数做不同装饰效果
# 避免去重复编写装饰代码 多个函数参数区分封装起到不同的装饰效果

def more_tips(arg):
    def tips(func):
        def inside(a, b):
            print('start %s %s' % (arg, func.__name__))
            func(a, b)
            print('stop %s' % arg)

        return inside

    return tips


@more_tips('+')
def add(a, b):
    print(a + b)


print(add(4, 5))
