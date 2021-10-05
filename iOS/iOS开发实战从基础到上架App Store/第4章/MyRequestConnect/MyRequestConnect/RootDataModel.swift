//
//  RootDataModel.swift
//  MyRequestConnect
//
//  Created by vip on 17/1/12.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit

class RootDataModel: NSObject {
    var allNum:Int = 0
    var allPages:Int = 0
    var ret_code:Int = 0;
    var contentlist:Array<Dictionary<String,Any>>=[]{
        willSet{
            contentModels.removeAll()
            for dic in newValue {
                let subModel = DataContentistModel()
                subModel.setValuesForKeys(dic)
                contentModels.append(subModel)
            }
        }
    }
    var contentModels:Array<DataContentistModel> = []
    var currentPage:Int = 0
    var maxResult:Int = 0
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}

class DataContentistModel: NSObject {
    var ct:String = ""
    var text:String = ""
    var title:String = ""
    var type:Int = 0
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
