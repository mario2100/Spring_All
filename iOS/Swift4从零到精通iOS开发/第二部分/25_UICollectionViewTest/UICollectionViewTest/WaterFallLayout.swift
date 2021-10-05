//
//  WaterFallLayout.swift
//  UICollectionViewTest
//
//  Created by vip on 16/9/23.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class WaterFallLayout: UICollectionViewFlowLayout {
    //封装一个属性 作为设置要布局的item个数
    let itemCount:Int
    //添加一个数组属性 存放每个Item的布局信息
    var attributeArray:Array<UICollectionViewLayoutAttributes>?
    
    
    //实现必要的构造方法
    required init?(coder aDecoder: NSCoder) {
        itemCount=0
        super.init(coder:aDecoder)
    }
    //自定义一个构造方法
    init(itemCount:Int){
        self.itemCount = itemCount
        super.init()
    }

    //这个方法用来准备布局 开发者在其中进行自定义布局设置
    override func prepare() {
        //调用父类的准备方法
        super.prepare()
        //设置为竖直布局
        self.scrollDirection = .vertical
        //初始化数组
        attributeArray = Array<UICollectionViewLayoutAttributes>()
        //先计算每个Item的宽度 默认2列布局
        let WIDTH = (UIScreen.main.bounds.size.width-self.minimumInteritemSpacing)/2
        //定义一个元组表示每一列的动态高度
        var queueHeight:(one:Int,two:Int) = (0,0)
        //进行循环设置
        for index in 0..<self.itemCount {
            //设置IndexPath 默认设置1个分区
            let indexPath = IndexPath(item: index, section: 0)
            //创建布局属性类
            let attris = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            //随机一个高度 40——190之间
            let height:Int = Int(arc4random()%150+40)
            //哪一列高度小 则把它放在哪一列下面
            //标记放在哪一列
            var queue = 0
            if queueHeight.one <= queueHeight.two {
                queueHeight.one += (height+Int(self.minimumInteritemSpacing))
                queue=0
            }else{
                queueHeight.two += (height+Int(self.minimumInteritemSpacing))
                queue=1
            }
            //设置Item位置
            let tmpH = queue == 0 ? queueHeight.one-height : queueHeight.two-height
            attris.frame = CGRect(x: (self.minimumInteritemSpacing+WIDTH)*CGFloat(queue), y: CGFloat(tmpH), width: WIDTH, height: CGFloat(height))
            //添加到数组中
            attributeArray?.append(attris)
        }
        //以高度最大的一列的高度 作为计算每个Item平局高度的中间值 这样可以保证滑动范围的正确
        if queueHeight.one<=queueHeight.two {
            self.itemSize = CGSize(width: WIDTH, height: CGFloat(queueHeight.two*2/self.itemCount)-self.minimumLineSpacing)
        }else{
            self.itemSize = CGSize(width: WIDTH, height: CGFloat(queueHeight.one*2/self.itemCount)-self.minimumLineSpacing)
        }
    }
    //实现这个方法 将设置好的 存放每个Item布局信息的数组返回
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributeArray
    }
}
