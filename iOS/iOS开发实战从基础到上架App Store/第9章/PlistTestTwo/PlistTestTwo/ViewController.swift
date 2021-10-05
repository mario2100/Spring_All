//
//  ViewController.swift
//  PlistTestTwo
//
//  Created by vip on 17/3/26.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //获取沙盒目录
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let plistPath1 = paths.first!
        //拼接得到完整的文件名
        let filename = plistPath1.appending("my.plist")
        let dic:NSDictionary = ["my":"test"]
        //写数据
        dic.write(toFile: filename, atomically: true)
        //取数据
        let getDic = NSDictionary(contentsOfFile: filename)
        print(getDic!)
        UserDefaults
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

