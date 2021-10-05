//
//  ViewController.swift
//  PlistTest
//
//  Created by vip on 16/10/20.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
//        super.viewDidLoad()
//        //获取文件路径
//        let path = Bundle.main.path(forResource: "MyPlist", ofType: "plist")
//        //将文件内容读成字典
//        let dic = NSDictionary(contentsOfFile: path!)
//        //数据输出
//        print(dic)
        
        //获取沙盒的用户数据目录
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        //拼接上文件名
        let fileName = path! + "/MyPlist.plist"
        let dic:NSDictionary = ["name":"jaki","age":"25"]
        //进行写文件
        dic.write(toFile: fileName, atomically: true)
        //将存储的Plist文件数据进行读取
        let dicRes = NSDictionary(contentsOfFile: fileName)
        print(dicRes ?? "dicRes为nil")
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

