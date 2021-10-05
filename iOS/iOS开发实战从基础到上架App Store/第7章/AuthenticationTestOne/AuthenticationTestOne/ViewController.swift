//
//  ViewController.swift
//  AuthenticationTestOne
//
//  Created by vip on 17/3/2.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit
import LocalAuthentication
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //创建安全验证对象
        let con = LAContext()
        //判断是否支持密码验证
        let can = con.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil)
        if can {
            con.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "请输入您的手机密码进行安全验证", reply: { (success, error) in
                print(success)
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

