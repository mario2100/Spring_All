# 文件操作 内置内建函数
# 只读
# file = open('name.txt')
# file = open('name.txt', 'w')
# file.write('诸葛亮')
# file.write('刘备')
# file.close()
# 读一行
# print(file.readline())
# 读取多行
# for line in file.readlines():
#     print(line)

# 文件指针 记录操作位置
# file = open('name.txt')
# print(file.tell())
# file.read(1)
# print(file.tell())

# 回到位置
# file.seek(0)
# file.read(1)
# print(file.tell())

# 读取人物
# name_file = open('name.txt')
# name_file_data = name_file.read();
# names = name_file_data.split('|')
# print(names)

# 读取兵器
# weapon_file = open('weapon.txt')
# 读取过后 再读没有反应
# weapon_file_data = weapon_file.read()
# print(weapon_file_data)

# i = 1
# for line in weapon_file.readlines():
#     if i % 2 == 1:
#         print(line.strip("\n"))
#     i += 1

# content_file = open('sanguo.txt', encoding='utf8')
# print(content_file.read().replace('\n', ''))

# def readTxt(path='name.txt'):
#     print(open(path).read())
#
#
# readTxt('weapon.txt')

# import re
#
#
# # 找英雄 找武器
# def find_item(hero_or_weapon):
#     with open('sanguo.txt', encoding='utf8') as content_file:
#         data = content_file.read().replace('\n', '')
#         name_num = re.findall(hero_or_weapon, data)
#         print('主角 %s 出现 %s 次' % (hero_or_weapon, len(name_num)))
#     return len(name_num)
#
#
# # 出现次数元祖
# name_dic = {}
# # 读英雄 readLines
# with open('name.txt') as heroes:
#     for line in heroes:
#         names = line.split('|')
#         for hero in names:
#             # print(hero)
#             name_num = find_item(hero)
#             name_dic[hero] = name_num
# # 排序
# name_sort = sorted(name_dic.items(), key=lambda item: item[1], reverse=True)
# print(name_dic)
# print(name_sort[0:10])
#
# weapon_dic = {}
# # 读武器
# i = 1
# with open('weapon.txt') as  weapons:
#     for weapon in weapons:
#         if i % 2 == 1:
#             weapon = weapon.strip("\n")
#             name_num = find_item(weapon)
#             weapon_dic[weapon] = name_num
#         i += 1
# name_sort = sorted(weapon_dic.items(), key=lambda item: item[1], reverse=True)
# print(weapon_dic)
# print(name_sort[0:10])

# 文件与文件目录访问

import os

print(os.path.abspath('..'))
print(os.path.exists('/Users'))
print(os.path.isfile('/Users'))
print(os.path.isdir('/Users'))
os.path.join('/Users/', 'jiangjunhe/Desktop/')

from pathlib import Path

p = Path('.')
print(p.resolve())
print(p.is_dir())
q = Path('/tmp/a')

Path.mkdir(q, parents=True)
