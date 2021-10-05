//
//  ViewController.swift
//  UIImageViewTest
//
//  Created by vip on 16/8/7.
//  Copyright © 2016年 jaki. All rights reserved.
//        //通过图片素材名称创建UIImage实例
//        let image = UIImage(named: "imageName")
//        //通过文件路径创建UIImage实例
//        let image2 = UIImage(contentsOfFile: "filePath")
//        //通过Data数据创建UIImage实例
//        let image3 = UIImage(data: Data())
//        //获取图片尺寸 返回CGSize类型的结构体
//         let size = image?.size

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let image = UIImage(named: "image")
        //创建UIImageView控件
        let imageView = UIImageView(image: image)
        //设置UIImageView控件的位置和尺寸
        imageView.frame = CGRect(x: 30, y: 30, width: 200, height: 200)
        //将控件添加在当前视图上
        self.view.addSubview(imageView)
        
        //创建一个数组 用于存放动画图片
        var imageArry = Array<UIImage>()
        //进行图片的循环创建
        for index in 1...8{
            //使用格式化的字符串进行创建
            let birdImage = UIImage(named: "bird\(index)")
            //将创建的图片添加进数组中
            imageArry.append(birdImage!)
        }
        //创建UIImageView
        let birdImageView = UIImageView(frame: CGRect(x: 30, y: 250, width: 200, height: 100))
        //设置动画数组
        birdImageView.animationImages = imageArry
        //设置动画播放时长
        birdImageView.animationDuration = 3
        //设置动画播放次数
        birdImageView.animationRepeatCount = 0
        self.view.addSubview(birdImageView)
        //开始播放动画
        birdImageView.startAnimating()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

