//
//  ViewController.swift
//  ArchiverTestTwo
//
//  Created by vip on 17/3/27.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //获取根目录
        let homeDictionary = NSHomeDirectory()
        //添加存储的文件名
        let homePath = homeDictionary.appending("atany.archiver")
        //这里创建一个data对象作为归档的容器
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        //对下面的字符串和整形值进行归档序列化
        archiver.encode("Jaki", forKey: "name")
        archiver.encode(24, forKey: "age")
        //写入数据
        archiver.finishEncoding()
        //写入文件
        data.write(toFile: homePath, atomically: true)
        //创建解归档的反序列化对象
        let unarchiver = NSKeyedUnarchiver(forReadingWith: data as Data)
        let name = unarchiver.decodeObject(forKey: "name")
        let age = unarchiver.decodeInt64(forKey: "age")
        print(name!,age)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

