//
//  ViewController.swift
//  CAShapeLayerTest
//
//  Created by vip on 17/2/20.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let layer = CAShapeLayer()
        layer.position = CGPoint(x: 0, y: 0)
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 100, y: 100))
        path.addLine(to: CGPoint(x: 300, y: 100))
        path.addLine(to: CGPoint(x: 200, y: 200))
        path.addLine(to: CGPoint(x: 100, y: 100))
        layer.path = path
        layer.strokeColor = UIColor.black.cgColor
        self.view.layer.addSublayer(layer)
        
        layer.fillColor = UIColor.red.cgColor
        layer.strokeColor = UIColor.blue.cgColor
        layer.strokeStart = 0.3
        layer.strokeEnd = 0.8
        layer.lineWidth = 4
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

