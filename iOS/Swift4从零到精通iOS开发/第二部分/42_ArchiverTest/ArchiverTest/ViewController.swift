//
//  ViewController.swift
//  ArchiverTest
//
//  Created by vip on 16/10/21.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        let homeDicPath = NSHomeDirectory()
//        let filePath = homeDicPath + "archiver.file"
//        NSKeyedArchiver.archiveRootObject("jaki", toFile: filePath)
//        
//        let name = NSKeyedUnarchiver.unarchiveObject(withFile: filePath)
//        print(name)
        
//        //获取根目录
//        let homeDicPath = NSHomeDirectory()
//        //创建文件完整路径
//        let filePath = homeDicPath + "archiver.file"
//        //创建归档载体数据
//        let mutableData = NSMutableData()
//        //创建归档对象
//        let archiver = NSKeyedArchiver(forWritingWith: mutableData)
//        //进行年龄数据编码
//        archiver.encode(24, forKey: "age")
//        //进行姓名数据编码
//        archiver.encode("jaki", forKey: "name")
//        //编码完成
//        archiver.finishEncoding()
//        //将数据写入文件
//        mutableData.write(toFile: filePath, atomically: true)
//        
//        let data = try? Data(contentsOf: URL(fileURLWithPath: filePath))
//        let unArchiver = NSKeyedUnarchiver(forReadingWith: data!)
//        let age = unArchiver.decodeInt32(forKey: "age")
//        let name = unArchiver.decodeObject(forKey: "name")
//        print("\(name):\(age)")
        
        //获取根目录
        let homeDicPath = NSHomeDirectory()
        //创建文件完整路径
        let filePath = homeDicPath + "archive.file"
        //创建People实例
        let people = People()
        people.name = "jaki";
        people.age = 24
        //进行归档
        NSKeyedArchiver.archiveRootObject(people, toFile: filePath)
        
        //进行解归档
        let getPeople = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as! People
        print("\(getPeople.name):\(getPeople.age)")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

