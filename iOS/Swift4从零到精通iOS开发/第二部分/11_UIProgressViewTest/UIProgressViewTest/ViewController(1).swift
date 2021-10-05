//
//  ViewController.swift
//  UIProgressViewTest
//
//  Created by vip on 16/8/21.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //创建进度条控件实例
        let progressView = UIProgressView(progressViewStyle: UIProgressViewStyle.default)
        //设置位置和宽度
        progressView.frame = CGRect(x: 20, y: 100, width: 280, height: 10)
        //设置当前进度
        progressView.progress = 0.5
        //设置已走过进度的进度条颜色
        progressView.progressTintColor = UIColor.green
        //设置未走过进度的进度条颜色
        progressView.trackTintColor = UIColor.red
        //添加到当前视图
        self.view.addSubview(progressView)
        
        progressView.progressImage = UIImage(named: "imageH")
        progressView.trackImage = UIImage(named: "imageN")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

