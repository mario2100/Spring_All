//
//  ViewController.swift
//  CAGradientLayerTest
//
//  Created by vip on 17/2/20.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let layer = CAGradientLayer()
        layer.colors = [UIColor.red.cgColor,UIColor.blue.cgColor]
        layer.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        layer.position = CGPoint(x: 100, y: 100)
        layer.locations = [0.2]
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x: 1, y: 1)
        self.view.layer.addSublayer(layer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

