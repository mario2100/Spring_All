//
//  ViewController.swift
//  UISliderTest
//
//  Created by vip on 16/8/18.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //对UISlider控件进行实例化
        let slider = UISlider(frame: CGRect(x: 20, y: 100, width: 280, height: 30))
        //设置滑块控件的最大值
        slider.maximumValue = 10
        //设置滑块控件的最小值
        slider.minimumValue = 0
        //初始化滑块控件的值
        slider.value = 5
        //设置滑块左侧进度条的颜色
        slider.minimumTrackTintColor = UIColor.red
        //设置滑块右侧进度条的颜色
        slider.maximumTrackTintColor = UIColor.green
        //设置滑块颜色
        slider.thumbTintColor = UIColor.blue
        //将滑块控件添加到当前视图
        self.view.addSubview(slider)
        
        //设置滑块图片
        slider.setThumbImage(UIImage(named: "image"), for: UIControlState())
        //设置滑块左侧进度图片
        slider.setMinimumTrackImage(UIImage(named: "imageS"), for: UIControlState())
        //设置滑块右侧进度图片
        slider.setMaximumTrackImage(UIImage(named: "imageS"), for: UIControlState())
        
        slider.addTarget(self, action: #selector(change), for: UIControlEvents.valueChanged)
        slider.isContinuous = false
    }
    
    func change(slider:UISlider)  {
        print(slider.value)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

