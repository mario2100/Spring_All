//
//  ViewController.swift
//  UIImageViewAnimationTest
//
//  Created by vip on 17/2/16.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let imageView = UIImageView(frame: CGRect(x: 100, y: 100, width: 42, height: 28))
        var imageArray = Array<UIImage>()
        for index in 0..<3 {
            let image = UIImage(named: "bird\(index+1)")
            imageArray.append(image!)
        }
        //设置动画图片数组
        imageView.animationImages = imageArray
        imageView.animationDuration = 1
        imageView.animationRepeatCount = 0
        self.view.addSubview(imageView)
        imageView.startAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

