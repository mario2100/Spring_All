//
//  ViewController.swift
//  CALayerTest
//
//  Created by vip on 16/12/18.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        btn.backgroundColor = UIColor.red
//        btn.layer.masksToBounds = true
//        btn.layer.cornerRadius = 10
//        btn.layer.borderColor = UIColor.green.cgColor
//        btn.layer.borderWidth = 5
        btn.layer.shadowColor = UIColor.gray.cgColor
        btn.layer.shadowOffset = CGSize(width: 10, height: 10)
        btn.layer.shadowOpacity = 1
        self.view.addSubview(btn)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

