//
//  ViewController.swift
//  CAKeyframeAnimationTest
//
//  Created by vip on 17/2/22.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var layer:CALayer?
    override func viewDidLoad() {
        super.viewDidLoad()
        layer = CALayer()
        layer?.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        layer?.backgroundColor = UIColor.red.cgColor
        layer?.position = CGPoint(x: 50, y: 100)
        self.view.layer.addSublayer(layer!)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let ani = CAKeyframeAnimation(keyPath: "position")
        ani.values = [CGPoint(x: 50, y: 100),CGPoint(x: 120, y: 100),CGPoint(x: 120, y: 200),CGPoint(x: 200, y: 200)]
        ani.keyTimes = [0,0.5,0.8,1]
        ani.duration = 3
        layer?.add(ani, forKey: "")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

