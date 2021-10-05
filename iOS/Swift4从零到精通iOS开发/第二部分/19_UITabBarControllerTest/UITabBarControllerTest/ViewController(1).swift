//
//  ViewController.swift
//  UITabBarControllerTest
//
//  Created by vip on 16/9/5.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //设置标签标题
        self.tabBarItem.title = "首页"
        //设置标签图标
        self.tabBarItem.image = UIImage(named: "imageNormal")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        //设置选中状态下的
        self.tabBarItem.selectedImage = UIImage(named: "imageSelect")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        self.view.backgroundColor = UIColor.red
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

