//
//  ViewController.swift
//  UserDefaultTest
//
//  Created by vip on 16/10/19.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //获取应用程序默认的userDefaults实例
        
//        let userDefaults = UserDefaults.standard
//        userDefaults.removeObject(forKey: "doubleKey")
//        print(userDefaults.url(forKey: "urlKey"))
//        print(userDefaults.string(forKey: "stringKey"))
//        print(userDefaults.bool(forKey: "boolKey"))
//        print(userDefaults.double(forKey: "doubleKey"))
//        print(userDefaults.float(forKey: "floatKey"))
//        print(userDefaults.integer(forKey: "intKey"))
//        print(userDefaults.dictionary(forKey: "dicKey"))
//        print(userDefaults.array(forKey: "arrKey"))
//        print(userDefaults.data(forKey: "dataKey"))
//        //进行url数据的存储
//        userDefaults.set(URL(string: "http://www.baidu.com"), forKey: "urlKey")
//        //进行字符串数据的存储
//        userDefaults.set("stringValue", forKey: "stringKey")
//        //进行Bool值数据的存储
//        userDefaults.set(true, forKey: "boolKey")
//        //进行Double类型数据的存储
//        userDefaults.set(Double(0.1), forKey: "doubleKey")
//        //进行Float类型数据的存储
//        userDefaults.set(Float(1.5), forKey: "floatKey")
//        //进行Int类型数据的存储
//        userDefaults.set(5, forKey: "intKey")
//        //进行字典数据的存储
//        userDefaults.set(["1":"一"], forKey: "dicKey")
//        //进行数据数据的存储
//        userDefaults.set([1,2,3,4], forKey: "arrKey")
//        //进行Data数据的存储
//        userDefaults.set(Data(), forKey: "dataKey")
//        //将操作进行同步
//        userDefaults.synchronize()
        var dic = UserDefaults.standard.persistentDomain(forName: UserDefaults.globalDomain)
        if dic == nil {
            dic = Dictionary<String,AnyObject>()
        }
        print(dic ?? "dict为空")
        dic?["应用程序A"] = "shared"
        UserDefaults.standard.setPersistentDomain(dic!, forName: UserDefaults.globalDomain)
        UserDefaults.resetStandardUserDefaults()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

