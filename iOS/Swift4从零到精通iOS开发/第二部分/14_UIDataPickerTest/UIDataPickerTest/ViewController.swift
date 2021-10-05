//
//  ViewController.swift
//  UIDataPickerTest
//
//  Created by vip on 16/8/23.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //创建UIDatePicker实例
        let datePicker = UIDatePicker(frame: CGRect(x: 20, y: 100, width: 280, height: 200))
        //设置时间选择器的模式
        datePicker.datePickerMode = UIDatePickerMode.countDownTimer
        //将控件添加到当前视图
        self.view.addSubview(datePicker)
        
        datePicker.addTarget(self, action: #selector(sele), for: UIControlEvents.valueChanged)
    }

    func sele(datePicker:UIDatePicker)  {
        //获取当前选择的日期或者时间
        let date = datePicker.date
        let time = datePicker.countDownDuration
        print(date,time)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

