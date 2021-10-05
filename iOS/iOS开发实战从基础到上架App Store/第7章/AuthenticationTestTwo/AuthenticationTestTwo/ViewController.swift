//
//  ViewController.swift
//  AuthenticationTestTwo
//
//  Created by vip on 17/3/2.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit
import LocalAuthentication
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let con = LAContext()
        let can = con.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        if can {
            con.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "验证指纹", reply: { (success, error) in
                print(success)
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

