//
//  ViewController.swift
//  CATransitionTest
//
//  Created by vip on 17/2/22.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let layer = CALayer()
        layer.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        layer.position = CGPoint(x: 100, y: 100)
        layer.backgroundColor = UIColor.red.cgColor
        let ani = CATransition()
        ani.type = kCATransitionPush
        ani.subtype = kCATransitionFromRight
        ani.duration = 3
        layer.add(ani, forKey: "")
        self.view.layer.addSublayer(layer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

