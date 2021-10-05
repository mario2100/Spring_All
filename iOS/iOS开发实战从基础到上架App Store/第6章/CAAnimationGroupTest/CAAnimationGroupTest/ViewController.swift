//
//  ViewController.swift
//  CAAnimationGroupTest
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
        layer?.position = CGPoint(x: 100, y: 100)
        layer?.backgroundColor = UIColor.red.cgColor
        self.view.layer.addSublayer(layer!)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let ani1 = CABasicAnimation(keyPath: "backgroundColor")
        ani1.toValue = UIColor.blue.cgColor
        let ani2 = CABasicAnimation(keyPath: "position")
        ani2.toValue = CGPoint(x: 200, y: 300)
        let group = CAAnimationGroup()
        group.duration = 3
        group.animations = [ani1,ani2]
        layer?.add(group, forKey: "")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

