//
//  ViewController.swift
//  CABasicAnimationTest
//
//  Created by vip on 17/2/21.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var layer:CALayer?
    override func viewDidLoad() {
        super.viewDidLoad()
        layer = CALayer()
        layer?.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        layer?.position = CGPoint(x: 160, y: 100)
        layer?.backgroundColor = UIColor.red.cgColor
        self.view.layer.addSublayer(layer!)
    }

//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        //背景色渐变动画
//        let ani = CABasicAnimation(keyPath: "backgroundColor")
//        //从红色开始
//        ani.fromValue = UIColor.red.cgColor
//        //渐变成蓝色
//        ani.toValue = UIColor.blue.cgColor
//        //时间2秒
//        ani.duration = 2
//        //执行动画
//        layer?.add(ani, forKey: "")
//    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let ani = CABasicAnimation(keyPath: "transform")
        //从0度开始
        ani.fromValue = 0
        //旋转到180度
        ani.toValue = M_PI
        //时间2秒
        ani.duration = 2
        //设置为z轴旋转
        ani.valueFunction = CAValueFunction(name: kCAValueFunctionRotateZ)
        //执行动画
        layer?.add(ani, forKey: "")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

