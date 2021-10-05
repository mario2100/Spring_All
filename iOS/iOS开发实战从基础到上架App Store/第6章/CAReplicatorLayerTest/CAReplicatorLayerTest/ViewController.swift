//
//  ViewController.swift
//  CAReplicatorLayerTest
//
//  Created by vip on 17/2/20.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let layer = CALayer()
        layer.bounds = CGRect(x: 0, y: 0, width: 50, height: 50)
        layer.position = CGPoint(x: 50, y: 100)
        layer.backgroundColor = UIColor.red.cgColor
        //创建拷贝容器
        let reLayer = CAReplicatorLayer()
        reLayer.instanceRedOffset = -0.2;
        reLayer.position = CGPoint(x: 0, y: 0)
        reLayer.instanceTransform = CATransform3DMakeTranslation(100, 0, 0)
        reLayer.instanceCount = 3
        reLayer.addSublayer(layer)
        self.view.layer.addSublayer(reLayer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

