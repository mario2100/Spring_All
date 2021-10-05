//
//  ViewController.swift
//  PlistTestOne
//
//  Created by vip on 17/3/24.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //获取plist文件路径
        let path = Bundle.main.path(forResource: "NewPlist", ofType: "plist")
        //获取plist文件内容
        let root = NSDictionary(contentsOfFile: path!)
        for (key,value) in root! {
            print("\(key):\(value)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

