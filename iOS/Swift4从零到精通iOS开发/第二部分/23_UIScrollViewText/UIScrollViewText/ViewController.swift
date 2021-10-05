//
//  ViewController.swift
//  UIScrollViewText
//
//  Created by vip on 16/9/16.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate {

    var imageView:UIImageView?
    override func viewDidLoad() {
        super.viewDidLoad()
        //进行UIScrollView的实例化
        let scrollView = UIScrollView(frame: self.view.frame)
        //将滚动视图添加到当前界面
        self.view.addSubview(scrollView)
//        //创建两个内容视图
//        let subView1 = UIView(frame: self.view.frame)
//        subView1.backgroundColor = UIColor.red
//        let subView2 = UIView(frame: CGRect(x: self.view.frame.size.width, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
//        subView2.backgroundColor = UIColor.blue
//        //将内容视图添加进UIScrollView视图中
//        scrollView.addSubview(subView1)
//        scrollView.addSubview(subView2)
        //设置UIScrollView实例的
//        scrollView.contentSize = CGSize(width: self.view.frame.size.width*2, height: self.view.frame.size.height)
        
//        //设置始终开启竖直方向的回弹效果
//        scrollView.alwaysBounceVertical = true
//        //设置始终开启水平方向的回弹效果
//        scrollView.alwaysBounceHorizontal = true
//        
//        //显示竖直方向的进度提示条
//        scrollView.showsVerticalScrollIndicator = true
//        //显示水平方向的进度提示条
//        scrollView.showsHorizontalScrollIndicator = false
//        
//        //开启自动定位分页
//        scrollView.isPagingEnabled = true
        
        //设置代理
        scrollView.delegate = self
        imageView = UIImageView(image: UIImage(named: "image"))
        imageView?.frame = self.view.frame
        scrollView.addSubview(imageView!)
        scrollView.contentSize = self.view.frame.size
        
        //设置缩放限度
        scrollView.minimumZoomScale = 0.5
        scrollView.maximumZoomScale = 2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView!
    }


}

