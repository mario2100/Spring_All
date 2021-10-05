//
//  ViewController.swift
//  ArchiverTestOne
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
        //拼接文件名
        let homePath = homeDictionary.appending("atany.archiver")
        //归档方式一：通过data数据归档 将数据写入文件
        let data = NSKeyedArchiver.archivedData(withRootObject: "123")
        try! data.write(to: URL(fileURLWithPath: homePath))
        //方式二：直接写入文件
        NSKeyedArchiver.archiveRootObject("456", toFile: homePath)
        //方式一的解归档
        print(NSKeyedUnarchiver.unarchiveObject(with: data)!)
        //方式二的解归档
        print(NSKeyedUnarchiver.unarchiveObject(withFile: homePath)!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

