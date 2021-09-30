# 后续类的讲解中详述：自定义上下文管理器 with

file = open('name.txt')
try:
    for line in file:
        print(line)
finally:
    file.close()

with open('name.txt') as f:
    for line in f:
        print(line)
