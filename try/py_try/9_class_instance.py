# 类 与 实例

# 面向过程 根据执行顺序 从上到下依次编程

# 定义一个类
class Player():
    # 构造函数
    def __init__(self, name, hp):
        self.name = name
        self.hp = hp

    # 定义一个方法
    def print_role(self):
        print('%s: %s' % (self.name, self.hp))

        # 类实例化一个对象

    def __enter__(self):
        print('run')

    def __exit__(self, exc_type, exc_val, exc_tb):
        if exc_tb is None:
            print('exit with 0')
        else:
            print('exit with error:%s' % exc_tb)


# user1 = Player('Tom', 100)
# user1.print_role()

# pass  // todo
# get set


# 继承 super 父类初始化了、子类不要再初始化了
# 方法 重名会覆盖 方法状态：多态
# 父子类 instance of  isinstance() object

# with简化异常编写
with Player('Tom', 100):
    print('test')
    # 手动抛出异常
    raise NameError('testError')
