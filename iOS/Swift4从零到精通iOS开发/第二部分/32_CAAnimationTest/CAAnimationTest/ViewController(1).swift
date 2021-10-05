//
//  ViewController.swift
//  CAAnimationTest
//
//  Created by vip on 16/10/9.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //创建动画实例  keyPath为要进行属性动画的属性路径
//        let basicAni = CABasicAnimation(keyPath: "transform.rotation.z")
//        //从0度开始旋转
//        basicAni.fromValue = NSNumber(value: 0)
//        //旋转到180度
//        basicAni.toValue = NSNumber(value: M_PI)
//        //设置动画播放的时长
//        basicAni.duration = 2
//        //将动画作用于当前界面的视图Layer层上
//        self.view.layer.add(basicAni, forKey: nil)
        
//        let keyframeAni = CAKeyframeAnimation(keyPath: "transform.rotation.z")
//        keyframeAni.values = [NSNumber(value: 0),NSNumber(value: M_PI_4),NSNumber(value: 0),NSNumber(value: M_PI)]
//        keyframeAni.duration = 3
//        self.view.layer.add(keyframeAni, forKey: "")
        
//        let springAni = CASpringAnimation(keyPath: "position.y")
//        springAni.mass = 2
//        springAni.stiffness = 5
//        springAni.damping = 2
//        springAni.toValue = 300
//        springAni.duration = 3
//        
//        let layer = CALayer()
//        layer.position = CGPoint(x: 100, y: 100)
//        layer.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
//        layer.backgroundColor = UIColor.red.cgColor
//        self.view.layer.addSublayer(layer)
//        layer.add(springAni, forKey: "")
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //创建背景色过渡动画
        let basicAni = CABasicAnimation(keyPath: "backgroundColor")
        basicAni.toValue = UIColor.green.cgColor
        //创建形变动画
        let basicAni2 = CABasicAnimation(keyPath: "transform.scale.x")
        basicAni2.toValue = NSNumber(value: 2)
        //进行动画组合
        let groupAni = CAAnimationGroup()
        groupAni.animations = [basicAni,basicAni2]
        groupAni.duration = 3
        let layer = CALayer()
        layer.position = CGPoint(x: 100, y: 100)
        layer.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        layer.backgroundColor = UIColor.red.cgColor
        layer.add(groupAni, forKey: "")
        self.view.layer.addSublayer(layer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

