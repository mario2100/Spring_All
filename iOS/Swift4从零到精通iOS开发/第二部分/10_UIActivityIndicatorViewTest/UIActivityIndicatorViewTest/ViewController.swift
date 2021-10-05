//
//  ViewController.swift
//  UIActivityIndicatorViewTest
//
//  Created by vip on 16/8/20.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //设置当前界面的背景色
        self.view.backgroundColor = UIColor.red
        let activity = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        activity.center = self.view.center;
        //开始播放
        activity.startAnimating()
        //添加到当前视图
        self.view.addSubview(activity)
        
        //设置活动指示器颜色
        activity.color = UIColor.green
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

