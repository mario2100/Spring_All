//
//  ViewController.swift
//  UIViewTransAnimation
//
//  Created by vip on 16/9/27.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var animationView:UIView?
    override func viewDidLoad() {
        super.viewDidLoad()
        //创建视图
        animationView = UIView(frame: CGRect(x: 20, y: 100, width: 280, height: 300))
        animationView?.backgroundColor = UIColor.red
        self.view.addSubview(animationView!)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        UIView.transition(with: animationView!, duration: 3, options: .transitionCurlUp, animations: {
//                //这里可以进行视图上内容的重构
//            }, completion: nil)
        let otherView = UIView(frame: CGRect(x: 20, y: 100, width: 280, height: 300))
        otherView.backgroundColor = UIColor.blue
        UIView.transition(from: animationView!, to: otherView, duration: 3, options: .transitionFlipFromRight, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

