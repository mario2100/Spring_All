//
//  ViewController.swift
//  NSUserDefaultsTest
//
//  Created by vip on 17/3/26.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //获取单例对象
        let defaults = UserDefaults.standard
//        //进行数据存储
//        defaults.set("测试数据", forKey: "test")
//        //同步到磁盘
//        defaults.synchronize()
        //获取数据
        let str = defaults.string(forKey: "test")
        print(str!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

