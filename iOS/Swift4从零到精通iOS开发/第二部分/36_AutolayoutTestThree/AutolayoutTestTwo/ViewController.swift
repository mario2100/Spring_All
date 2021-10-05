//
//  ViewController.swift
//  AutolayoutTestTwo
//
//  Created by vip on 16/10/13.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let view = UIView()
        //要使用自动布局 需要将视图的translatesAutoresizingMaskIntoConstraints设置为false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.red
        //在添加约束之前 需要将视图添加到父视图上
        self.view.addSubview(view)
//        //创建约束对象
//        let layoutConstraint = NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
//        let layoutConstraint2 = NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0)
//        let layoutConstraint3 = NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 200)
//        let layoutConstraint4 = NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 200);
//       //为当前界面添加约束
//        self.view.addConstraints([layoutConstraint,layoutConstraint2,layoutConstraint3,layoutConstraint4])
        let stringH = "H:|-60-[view]-60-|"
        let stringV = "V:|-60-[view(200)]"
        let constraintArrayH = NSLayoutConstraint.constraints(withVisualFormat: stringH, options: NSLayoutFormatOptions(), metrics: nil, views: ["view":view])
        let constraintArrayV = NSLayoutConstraint.constraints(withVisualFormat: stringV, options: NSLayoutFormatOptions(), metrics: nil, views: ["view":view])
        self.view.addConstraints(constraintArrayH)
        self.view.addConstraints(constraintArrayV)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

