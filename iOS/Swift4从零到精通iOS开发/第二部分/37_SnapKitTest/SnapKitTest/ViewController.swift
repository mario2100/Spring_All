//
//  ViewController.swift
//  SnapKitTest
//
//  Created by vip on 16/10/14.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let view = UIView()
        view.backgroundColor = UIColor.red
        //添加约束前 必须将视图添加到其父视图上
        self.view.addSubview(view)
        //使用SnapKit添加约束
        view.snp.makeConstraints { (make) in
            make.left.top.equalTo(20)
            make.bottom.right.equalTo(-20)
        }
//        view.snp.updateConstraints { (make) in
//            
//        }
        //view.snp.removeConstraints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

