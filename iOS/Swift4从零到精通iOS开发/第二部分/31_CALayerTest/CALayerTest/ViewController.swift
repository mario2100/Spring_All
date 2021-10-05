//
//  ViewController.swift
//  CALayerTest
//
//  Created by vip on 16/10/5.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        //创建图层对象
//        let gradientLayer = CAGradientLayer()
//        //设置图层尺寸与位置
//        gradientLayer.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
//        gradientLayer.position = CGPoint(x: 100, y: 100)
//        //设置要进行色彩渐变的颜色
//        gradientLayer.colors = [UIColor.red.cgColor,UIColor.green.cgColor,UIColor.blue.cgColor]
//        //设置要进行渐变的临界位置
//        gradientLayer.locations = [NSNumber(value: 0.2),NSNumber(value: 0.5),NSNumber(value: 0.7)]
//        //设置渐变的起始点与结束点
//        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
//        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
//        //添加到当前视图上
//        self.view.layer.addSublayer(gradientLayer)
        
//        let replicatorLayer = CAReplicatorLayer()
//        replicatorLayer.position = CGPoint.zero
//        let subLayer = CALayer()
//        subLayer.bounds = CGRect(x: 0, y: 0, width: 20, height: 20)
//        subLayer.position = CGPoint(x: 30, y: 100)
//        subLayer.backgroundColor = UIColor.red.cgColor
//        replicatorLayer.addSublayer(subLayer)
//        replicatorLayer.instanceTransform = CATransform3DMakeTranslation(30, 0, 0)
//        replicatorLayer.instanceCount = 10
//        self.view.layer.addSublayer(replicatorLayer)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.position = CGPoint.zero
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 100, y: 100))
        path.addLine(to: CGPoint(x: 300, y: 100))
        path.addLine(to: CGPoint(x: 200, y: 200))
        path.addLine(to: CGPoint(x: 100, y: 100))
        shapeLayer.path = path
        shapeLayer.strokeStart = 0
        shapeLayer.strokeEnd = 1
        shapeLayer.fillRule = kCAFillRuleEvenOdd
        shapeLayer.fillColor = UIColor.red.cgColor
        shapeLayer.strokeColor = UIColor.blue.cgColor
        shapeLayer.lineWidth = 1
        self.view.layer.addSublayer(shapeLayer)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

