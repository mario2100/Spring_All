//
//  Model.swift
//  ArchiveTestThree
//
//  Created by vip on 17/3/27.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit

class Model: NSObject,NSCoding {
    var name:String?
    var age:Int64 = 0
    override init() {
        super.init()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init()
        name = aDecoder.decodeObject(forKey: "name") as! String?
        age = aDecoder.decodeInt64(forKey: "age")
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(age, forKey: "age")
    }
}
