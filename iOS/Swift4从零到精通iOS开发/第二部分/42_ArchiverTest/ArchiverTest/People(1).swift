//
//  People.swift
//  ArchiverTest
//
//  Created by vip on 16/10/21.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit
//遵守NSCoding协议
class People: NSObject,NSCoding {
    //添加名称和年龄属性
    var name:String?
    var age:NSInteger = 0
    //构造方法
    override init() {
        super.init()
    }
    //解归档方法
    required init?(coder aDecoder: NSCoder) {
        super.init()
        self.name = aDecoder.decodeObject(forKey: "name") as! String?;
        self.age = aDecoder.decodeInteger(forKey: "age")
    }
    //归档方法
    func encode(with aCoder: NSCoder) {
        aCoder.encode(age, forKey: "age")
        aCoder.encode(name, forKey: "name")
    }
}
