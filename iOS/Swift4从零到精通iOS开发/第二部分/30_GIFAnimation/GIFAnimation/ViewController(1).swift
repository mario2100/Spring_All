//
//  ViewController.swift
//  GIFAnimation
//
//  Created by vip on 16/9/29.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit
import ImageIO

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        let imageView = UIImageView(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
//        self.view.addSubview(imageView)
//        self.playGIFOnImageView(name: "animation", imageView: imageView)
        let webView = UIWebView(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
        self.view.addSubview(webView)
        self.playGIFOnWebView(name: "animation", webView: webView)
    }

    func playGIFOnImageView(name:String,imageView:UIImageView) {
        //创建素材路径
        let path = Bundle.main.path(forResource: name, ofType: "gif")
        //通过路径创建素材url
        let url = URL.init(fileURLWithPath: path!)
        //创建素材实例
        let source = CGImageSourceCreateWithURL(url as CFURL, nil)
        //获取素材中图片张数
        let count = CGImageSourceGetCount(source!)
        //创建数组用于存放所有图片
        var imageArray = Array<UIImage>()
        //创建数组用于存放图片的宽度
        var imagesWidth = Array<Int>()
        //创建数组用于存放存片的高度
        var imagesHeight = Array<Int>()
        //用于存放GIF播放时长
        var time:Int = Int()
        //遍历素材
        for index in 0..<count {
            //从素材实例中获取图片
            let image = CGImageSourceCreateImageAtIndex(source!, index, nil)
            //将图片加入数组中
            imageArray.append(UIImage(cgImage: image!))
            //获取图片信息数组
            let info = CGImageSourceCopyPropertiesAtIndex(source!, index, nil) as! Dictionary<String,AnyObject>
            //获取宽高
            let width = Int(info[kCGImagePropertyPixelWidth as String]! as! NSNumber)
            let height = Int(info[kCGImagePropertyPixelHeight as String]! as! NSNumber)
            imagesWidth.append(width)
            imagesHeight.append(height)
            //获取时间信息
            let timeDic = info[kCGImagePropertyGIFDictionary as String] as! Dictionary<String,AnyObject>
            //进行时间累加
            time += Int(timeDic[kCGImagePropertyGIFDelayTime as String] as! NSNumber)
        }
        //重设imageView尺寸
        //由于大部分GIF文件中所有图片尺寸相同 这里随便取一个即可
        imageView.frame = CGRect(x: 0, y: 100, width: imagesWidth[0], height: imagesHeight[0])
        //进行动画播放
        imageView.animationImages = imageArray
        imageView.animationDuration = TimeInterval(time)
        imageView.animationRepeatCount = 0
        imageView.startAnimating()
    }
    
    
    func playGIFOnWebView(name:String,webView:UIWebView) {
        //创建素材路径
        let path = Bundle.main.path(forResource: name, ofType: "gif")
        //通过路径创建素材url
        let url = URL.init(fileURLWithPath: path!)
        //将GIF素材读取成Data数据
        let imageData = try! Data(contentsOf: url)
        //设置WebView不允许滚动
        webView.scrollView.bounces = false
        //设置WebVIew背景色透明
        webView.backgroundColor = UIColor.clear
        //设置WebView自适应缩放
        webView.scalesPageToFit = true
        //加载GIF数据
        webView.load(imageData, mimeType: "image/gif", textEncodingName: "", baseURL: URL(string: Bundle.main.bundlePath)!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

