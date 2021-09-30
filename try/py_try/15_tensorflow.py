# tensorflow
# 机器学习分类原理

# 方程组 算法设计---训练数据---预测工具 模型


#  鸢尾花分类案例

from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

import tensorflow as tf
import argparse
import iris_data

parser = argparse.ArgumentParser()
parser.add_argument('--batch_size', default=100, type=int, help='batch size')
parser.add_argument('--batch_steps', default=100, type=int, help='number of training steps')


def main(argv):
    args = parser.parse_args(argv[1:])
    # 测试数据

    (train_x, train_y), (test_x, test_y) = iris_data.load_dara()

    my_feature_columns = []
    for key in train_x.keys():
        my_feature_columns.append(tf.feature_column.numeric_column(key=key))

    classifer = tf.estimator.DNNClassifier(feature_columns=my_feature_columns, hidden_units=[10, 10], n_classes=3)
    predication = classifer.predict(
        input_fn=lambda: iris_data.eval_input_fn(predict_x, labels=none, batch_size=args.batch_size))
