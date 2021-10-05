//
//  ViewController.swift
//  CATextLayerTest
//
//  Created by vip on 17/2/21.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let layer = CATextLayer()
        layer.bounds = CGRect(x: 0, y: 0, width: 320, height: 100)
        layer.position = CGPoint(x: 160, y: 100)
        layer.string = "我是文字Layer"
        layer.fontSize = 25
        layer.foregroundColor = UIColor.red.cgColor
        layer.alignmentMode = kCAAlignmentCenter
        self.view.layer.addSublayer(layer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

