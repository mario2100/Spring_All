# 机器学习库

# numpy 库 高性能科学计算与数据分析  基础包

# 机器算法计算结果符合预期测试结果 建模

import numpy as np

# 与列表相似 但更高级 numpy数组
# print(123)
# arr1 = np.array([1, 2, 3, 4])
# print(arr1.dtype)
# arr2 = np.array([1.2, 2, 3, 4])
# print(arr2.dtype)
# print(arr1 + arr2)
#
# # 标量 没有方向 矢量
# data = [[1, 2, 3], [4, 5, 6]]
# # 二维矩阵
# arr3 = np.array(data)
# print(arr3)
# print(arr3.dtype)
#
# print(np.zeros((3, 5)))
#
# print(np.ones((3, 5)))
#
# print(np.empty((2, 3, 2)))

# 切片运算 0 开始计算
# arr4 = np.arange(10)
# print(arr4[5])
# print(arr4[5:8])
# arr4[5:8] = 10
# print(arr4)
#
# arr_slice = arr4[5:8].copy()
# arr_slice[:] = 15
# print(arr_slice)

# pandas 数据预处理和清洗库

# 一纬数据 Series 二维数据 DataFrame
from pandas import Series, DataFrame
import pandas as pd

# 数据索引
# obj = Series([4, 5, 6, -7])
# print(obj)
# print(obj.index)
# print(obj.values)

# 字典 构造 Series

# 数据表格 DataFrame
# pop = {'bj': {2008: 1.5, 2009: 2.0}, 'sh': {2008: 2.0, 2009: 3.6}}
# frame = DataFrame(pop)
# print(frame.T)

# 指定索引 过滤缺失值
# obj1 = Series(['blue', 'purple', 'yellow'], index=[0, 2, 4])
# print(obj1.reindex(range(6)))
# print(obj1.reindex(range(6), method='ffill'))
# print(obj1.reindex(range(6), method='bfill'))

from numpy import nan as NA

# 删除缺失值
# data = Series([1, NA, 2])
# print(data.dropna())
#
# data1 = DataFrame([[1, 2, 3], [1, NA, NA], [NA, NA, NA]])
# print(data1.dropna())
# print(data1.dropna(axis=1, how='all'))
#
# data2 = DataFrame([[1, 2, NA], [1, NA, NA], [NA, NA, NA]])
# print(data2.dropna(axis=1, how='all'))
#
# # 填充缺失值
# # 副本
# data2.fillna(0)
# print(data2)
# data2.fillna(0, inplace=True)
# print(data2)

# 层次化索引

# data3 = Series(np.random.randn(10),
#                index=[['a', 'a', 'a', 'b', 'b', 'b', 'c', 'c', 'd', 'd', ], [1, 2, 3, 1, 2, 3, 1, 2, 2, 3]])
# print(data3)
# # 一维转换二维数据 data frame
# print(data3.unstack())
# print(data3.unstack().stack())

# 绘图库 预处理和清洗之后 绘图 人工检查数据使用情况
import matplotlib.pyplot as plt

# plt.plot([1, 3, 5], [4, 8, 10])
# plt.show()
#
# x = np.linspace(-np.pi, np.pi, 100)
# plt.plot(x, np.sin(x))
# plt.show()

# 绘制多条曲线
# x = np.linspace(-np.pi * 2, np.pi * 2, 100)
# 创建图表1
# plt.figure(1, dpi=50)
# for i in range(1, 5):
#     plt.plot(x, np.sin(x / i))
# plt.show()

# 直方图
# data = [1, 1, 2, 3, 4, 5, 5, 6, 6, 6]
# plt.hist(data)
# plt.show()

# 散点图
x = np.arange(1, 10)
y = x
plt.scatter(x, y, c='r', marker='o')
plt.show()

import pandas as pd

# pd.read_csv()

# 修饰 图
