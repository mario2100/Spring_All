//
//  ViewController.swift
//  ProximityMonitorTest
//
//  Created by vip on 17/3/3.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //开启获取设备距离感应器数据
        UIDevice.current.isProximityMonitoringEnabled = true
        //添加监听距离感应器数据的变化
        NotificationCenter.default.addObserver(self, selector: #selector(notice), name: Notification.Name.UIDeviceProximityStateDidChange, object: nil)
    }
    func notice()  {
        if UIDevice.current.proximityState {
            print("距离近")
        }else{
            print("距离远")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

