//
//  ViewController.swift
//  AutolayoutTestThree
//
//  Created by vip on 17/3/21.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let view1 = UIView()
        view1.translatesAutoresizingMaskIntoConstraints = false
        view1.backgroundColor = UIColor.red
        //添加约束前 必须将子视图添加在父视图上
        self.view.addSubview(view1)
        //将view1视图约束在屏幕竖直方向的中间
        let constraintX = NSLayoutConstraint(item: view1, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
        self.view.addConstraint(constraintX)
        //将view1视图约束在屏幕水平方向的中间
        let constraintY = NSLayoutConstraint(item: view1, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0)
        self.view.addConstraint(constraintY)
        //将视图的看度约束为100
        let constraintW = NSLayoutConstraint(item: view1, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100)
        view1.addConstraint(constraintW)
        //将视图的高度约束为100
        let constraintH = NSLayoutConstraint(item: view1, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100)
        view1.addConstraint(constraintH)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

