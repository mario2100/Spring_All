//
//  ViewController.swift
//  UIImageViewGIF
//
//  Created by vip on 17/2/24.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit
import ImageIO
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let imageView = UIImageView(frame: CGRect(x: 20, y: 100, width: 280, height: 200))
        self.view.addSubview(imageView)
        let dataPath = Bundle.main.path(forResource: "gifImage", ofType: "gif")
        //获取GIF文件数据
        let source = CGImageSourceCreateWithURL(URL(fileURLWithPath: dataPath!) as CFURL, nil)
        //获取GIF文件中图片的个数
        let count = CGImageSourceGetCount(source!)
        //定义一个变量记录gif播放一轮的时间
        var allTime:Float = 0.0
        //存放图片
        var imageArray = Array<UIImage>()
        for i in 0..<count{
            let image = CGImageSourceCreateImageAtIndex(source!, i, nil)
            imageArray.append(UIImage(cgImage: image!))
            //获取图片信息
            let info = CGImageSourceCopyPropertiesAtIndex(source!, i, nil) as! Dictionary<String,Any>
            let timeDic = info[kCGImagePropertyGIFDictionary as String] as! Dictionary<String,Any>
            let time = timeDic[kCGImagePropertyGIFDelayTime as String]
            allTime += time as! Float
        }
        imageView.animationImages = imageArray
        imageView.animationDuration = TimeInterval(allTime)
        imageView.animationRepeatCount = -1
        imageView.startAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

