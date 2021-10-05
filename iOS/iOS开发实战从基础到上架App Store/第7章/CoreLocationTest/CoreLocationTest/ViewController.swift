//
//  ViewController.swift
//  CoreLocationTest
//
//  Created by vip on 17/3/7.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit
import CoreLocation
class ViewController: UIViewController,CLLocationManagerDelegate {
    private var manager:CLLocationManager?
    override func viewDidLoad() {
        super.viewDidLoad()
        //初始化一个定位管理对象
        manager = CLLocationManager()
        //申请定位服务权限
        manager?.requestAlwaysAuthorization()
        manager?.delegate = self//设置代理
        //开启定位服务
        manager?.startUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
    }
}

