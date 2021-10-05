//
//  ViewController.swift
//  UIStepperTest
//
//  Created by vip on 16/8/22.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //创建UIStepper实例
        let stepper = UIStepper(frame: CGRect(x: 100, y: 100, width: 0, height: 0))
        //设置控件颜色
        stepper.tintColor = UIColor.red
        //设置控件的最小值
        stepper.minimumValue = 0
        //设置控件的最大值
        stepper.maximumValue = 10
        //设置控件的步长
        stepper.stepValue = 1
        //将控件添加到当前视图
        self.view.addSubview(stepper)
        
        stepper.isContinuous = true
        stepper.autorepeat = false
        stepper.addTarget(self, action: #selector(click), for: UIControlEvents.valueChanged)
    }

    
    func click(stepper:UIStepper) {
        print("步进控制器的值\(stepper.value)")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

