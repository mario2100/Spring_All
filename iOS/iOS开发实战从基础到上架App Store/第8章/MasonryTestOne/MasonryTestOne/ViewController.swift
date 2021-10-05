//
//  ViewController.swift
//  MasonryTestOne
//
//  Created by vip on 17/3/24.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit
import SnapKit
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let label = UILabel()
        self.view.addSubview(label)
        let label2 = UILabel()
        self.view.addSubview(label2)
        label.snp.makeConstraints { (maker) in
            maker.height.equalTo(100)
            maker.width.equalTo(label2)
            maker.right.equalTo(label2.snp.left).offset(-100)
            maker.leading.equalTo(self.view).offset(20)
            maker.centerY.equalTo(self.view)
        }
        label2.snp.makeConstraints { (maker) in
            maker.height.equalTo(100)
            maker.centerY.equalTo(label)
            maker.trailing.equalTo(self.view.snp.trailing).offset(-20)
        }
        label.backgroundColor = UIColor.red
        label2.backgroundColor = UIColor.blue
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

