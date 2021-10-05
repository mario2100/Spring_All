//
//  MyLayout.swift
//  UICollectionViewTestOne
//
//  Created by vip on 17/1/2.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit

class MyLayout: UICollectionViewFlowLayout {
    var itemCount:Int?
    var attributeArray:Array<UICollectionViewLayoutAttributes>?
    override func prepare() {
        super.prepare()
        attributeArray = Array<UICollectionViewLayoutAttributes>()
        //设置为两列
        //计算每个item的宽度
        let WIDTH = (UIScreen.main.bounds.size.width-self.sectionInset.left-self.sectionInset.right-self.minimumInteritemSpacing)/2
        //定义数组保存每一列的高度
        //这个数组的主要作用是保存每一列的总高度，这样在布局时，我们可以始终将下一个Item放在最短的列下面
        var colHeight = Array<CGFloat>()
        colHeight.append(self.sectionInset.top)
        colHeight.append(self.sectionInset.top)
        //itemCount是外界传进来的item的个数，遍历来设置每一个item的布局
        for index in 0..<itemCount! {
            let indexPath = IndexPath(item: index, section: 0)
            //创建一个布局属性类，通过indexPath来创建
            let attris = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            //创建一个布局属性类，通过indexPath来创建
            let height = arc4random()%150+40
            //哪一列高度小，则放到那一列下面
            //标记最短的列
            var width = 0
            if colHeight[0]<colHeight[1]{
                colHeight[0] = colHeight[0] + CGFloat(height) + self.minimumLineSpacing
                width = 0
            }else{
                colHeight[1] = colHeight[1] + CGFloat(height) + self.minimumLineSpacing
                width = 1
            }
            //设置item的位置
            attris.frame = CGRect(x: self.sectionInset.left+(self.minimumInteritemSpacing+WIDTH)*CGFloat(width), y: colHeight[width]-CGFloat(height)-self.minimumLineSpacing, width: WIDTH, height: CGFloat(height))
            attributeArray?.append(attris)
        }
         //设置itemSize来确保滑动范围的正确，这里是通过将所有的item高度平均化，计算出来的(以最高的列位标准)
        if colHeight[0]>colHeight[1] {
            self.itemSize = CGSize(width: WIDTH, height:(colHeight[0]-self.sectionInset.top)*2/CGFloat(itemCount!)-self.minimumLineSpacing);
        }else{
            self.itemSize = CGSize(width: WIDTH, height:(colHeight[1]-self.sectionInset.top)*2/CGFloat(itemCount!)-self.minimumLineSpacing);
        }
    }
    //这个方法中返回我们的布局数组
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributeArray!
    }
}
