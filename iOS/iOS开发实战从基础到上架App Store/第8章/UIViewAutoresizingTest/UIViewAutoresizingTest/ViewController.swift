//
//  ViewController.swift
//  UIViewAutoresizingTest
//
//  Created by vip on 17/3/20.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let view1 = UIView(frame: CGRect(x: 20, y: 40, width: 200, height: 200))
        view1.backgroundColor = UIColor.red
        let view2 = UIView(frame: CGRect(x: 10, y: 10, width: 100, height: 100))
        view2.backgroundColor = UIColor.green
        view1.addSubview(view2)
        self.view.addSubview(view1)
        view2.autoresizingMask = .flexibleLeftMargin
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

