//
//  ViewController.swift
//  UIPageControlTest
//
//  Created by vip on 16/8/14.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //实例化UIPageControl
        let pageControl = UIPageControl(frame: CGRect(x: 20, y: 100, width: 280, height: 30))
        //设置页数
        pageControl.numberOfPages = 10
        //设置背景色
        pageControl.backgroundColor = UIColor.red
        //设置页码点背景色
        pageControl.pageIndicatorTintColor = UIColor.green
        //设置当前选中页码点的颜色
        pageControl.currentPageIndicatorTintColor = UIColor.blue
        //设置当前选中的页码数
        pageControl.currentPage = 3
        //添加到当前视图
        self.view.addSubview(pageControl)
        
        //添加用户交互事件
        pageControl.addTarget(self, action: #selector(change), for: UIControlEvents.valueChanged)
        
    }
    
    
    
    func change(pageControl:UIPageControl)  {
        print("当前所在页码：\(pageControl.currentPage)")
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

