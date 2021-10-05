//
//  ViewController.swift
//  2_UIButtonTest
//
//  Created by vip on 16/8/5.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //创建UIButton实例
        let buttonOne = UIButton(type: UIButtonType.custom)
        //设置按钮位置与尺寸
        buttonOne.frame = CGRect(x: 0, y: 40, width: 100, height: 80)
        //设置按钮背景色
        buttonOne.backgroundColor = UIColor.purple
        //设置按钮标题
        buttonOne.setTitle("标题", for: UIControlState())
        //设置标题文字颜色
        buttonOne.setTitleColor(UIColor.white, for: UIControlState())
        //添加到当前视图
        self.view.addSubview(buttonOne)
        buttonOne.addTarget(self, action: #selector(touchBegin), for: UIControlEvents.touchUpInside)
        
        buttonOne.setImage(UIImage(named: "image"), for: UIControlState())
//        buttonOne.setBackgroundImage(UIImage(named: "image"), for: UIControlState())
        buttonOne.titleEdgeInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 20)
        buttonOne.imageEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 30, right: 0)
        
    }

    func touchBegin()  {
        print("用户点击了按钮")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

