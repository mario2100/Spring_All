# 标准库
# 内建函数 内建类型
# 基本类型的日常处理
# 系统 网络处理
# 数据处理
# 开发调试工具
# 正则表达式库

import re

# 正则表达式支持的符号 元字符

# 匹配前面的字符 0次到多次
# re1 = re.compile('ca*t')
# print(re1.match('caat'))
# print(re1.match('cabt'))
# print(re1.match('caaaaat'))
# print(re1.match('caabbbaat'))

# . 单个字符 ...多个字符
# re1 = re.compile('.')
# print(re1.match('caat'))
# 匹配三个任意字符
# re1 = re.compile('...')
# print(re1.match('caat'))
# re1 = re.compile('.{3}')
# print(re1.match('caat'))

# ^开头 搜索时用
# re1 = re.compile('^cat')
# print(re1.match('caat'))
# print(re1.match('cat'))
# print(re1.match('cat123'))

# $ 以结尾的字符  后边开始匹配
# re1 = re.compile('jpg$')
# print(re1.match('jpg'))
# print(re1.match('123jpg'))

# + 1次到多次
# re1 = re.compile('c+')
# print(re1.match('cct'))
# print(re1.match('cat'))
# print(re1.match('at'))

# ?  0或1次
# re1 = re.compile('c?t')
# print(re1.match('ct'))
# print(re1.match('t'))

# {m} a出现4次 {m，n} a出现m到n次
# re1 = re.compile('ca{4}t')
# print(re1.match('caaaat'))
# re1 = re.compile('ca{2,4}t')
# print(re1.match('caat'))
# print(re1.match('caaat'))print(re1.match('cabct'))
# print(re1.match('caaaat'))


# [bcd] 任意一个字符匹配成功即成功
# re1 = re.compile('c[abc]t')
# print(re1.match('cat'))
# print(re1.match('cbt'))
# print(re1.match('cct'))

# | 左边 右边 （）组合使用
# re1 = re.compile('c[abc]t')
# print(re1.match('cat'))
# print(re1.match('cbt'))
# print(re1.match('cct'))


# 转移字符 \d 数字 [0,9]+
# re1 = re.compile('c\dt')
# print(re1.match('c1t'))
# print(re1.match('c0t'))
# print(re1.match('c1t'))

# \D 匹配不包括数字的
# re1 = re.compile('c\Dt')
# print(re1.match('cat'))
# print(re1.match('c0t'))
# print(re1.match('c1t'))


# ()分组 ????
# re1 = re.compile('(03|04)')
# print(re1.match('2021-03-15'))
# print(re1.match('2021-04-15'))

# ^$ 空行 .*? 不使用贪婪模式  只匹配第一个匹配上的内容


# 匹配日期  分组功能 r不转义
# re1 = re.compile(r'(\d+)-(\d+)-(\d+)')
# print(re1.match('2020-08-09'))
# # 取出某一部分
# print(re1.match('2020-08-09').group(1))
# print(re1.match('2020-08-09').groups())


# 搜索功能 不完全匹配 只要包含部分规则则成功
# re1 = re.compile(r'(\d+)-(\d+)-(\d+)')
# print(re1.match('2020-08-09'))
# print(re1.search('aa2020-08-09'))

# sub函数 替换成空 r不转义 $ 到结尾 \D非数字
# phone = '13800011234 # 手机'
# print(re.sub(r'#.*$', '', phone))

# findall

# 日期时间操作库

# import datetime
import time
# print(time.time())
# print(time.localtime())
# print(time.strftime('%Y-%m-%d %H:%M:%S'))
# print(datetime.datetime.now())
#
# new_time = datetime.timedelta(minutes=10)
# print(datetime.datetime.now() + new_time)
#
# one_day = datetime.datetime(2008, 5, 27)
#
# new_time = datetime.timedelta(days=10)
# print(one_day + new_time)


# 数学相关库
# 密码
# import random
#
# print(random.randint(1, 10))
# print(random.randrange(1, 10))
# # 字符串也可以
# print(random.choice(['a', 'v', 'c']))
