# 多线程
import time
from threading import current_thread, Thread

# def my_thread(arg1, arg2):
#     print(current_thread().getName(), 'start')
#     print('%s %s ' % (arg1, arg2))
#     time.sleep(1)
#     print(current_thread().getName(), 'stop')


# 循环处理 单线程
# for i in range(1, 6, 1):
#     t1 = my_thread(i, i + 1)

# python3 threading 库


# 多线程 调用函数
# for i in range(1, 6, 1):
#     t1 = threading.Thread(target=my_thread, args=(i, i + 1))
#
#     t1.start()
#
# print(current_thread().getName(), 'end')


# 主线程先结束

# 线程同步

# 类的多线程处理
# class MyThread(threading.Thread):
#     def run(self):
#         print(current_thread().getName(), 'start')
#         print('run')
#         print(current_thread().getName(), 'stop')
#
#
# t1 = MyThread()
# t1.start()
# # 等待该线程结束
# t1.join()
#
# print(current_thread().getName(), 'end')

# 生产者与消费者问题
import random
from queue import Queue

queue = Queue(5)


class ProducerThread(Thread):
    def run(self):
        name = current_thread().getName()
        nums = range(100)
        global queue
        while True:
            num = random.choice(nums)
            queue.put(num)
            print('生产者 %s 生产了数据 %s' % (name, num))
            t = random.randint(1, 3)
            time.sleep(t)
            print('生产者 %s 随机休眠了 %s 秒' % (name, t))


class ConsumerThread(Thread):
    def run(self):
        name = current_thread().getName()
        global queue
        while True:
            num = queue.get()
            # 线程等待同步
            queue.task_done()
            print('消费者 %s 消费了数据 %s' % (name, num))
            t = random.randint(1, 3)
            time.sleep(t)
            print('消费者 %s 随机休眠了 %s 秒' % (name, t))


t1 = ProducerThread(name='p1')
t1.start()
t2 = ProducerThread(name='p2')
t2.start()
t3 = ConsumerThread(name='c1')
t3.start()

# t1 = ProducerThread(name='p1')
# t1.start()
# t2 = ConsumerThread(name='c1')
# t2.start()
# t3 = ConsumerThread(name='c2')
# t3.start()
