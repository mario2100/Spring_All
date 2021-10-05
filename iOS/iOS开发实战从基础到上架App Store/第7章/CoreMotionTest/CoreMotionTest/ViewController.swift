//
//  ViewController.swift
//  CoreMotionTest
//
//  Created by vip on 17/3/2.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit
import CoreMotion
class ViewController: UIViewController {

    private var manager:CMMotionManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //创建管理对象
        manager = CMMotionManager()
        //在当前线程中回调
        manager?.startAccelerometerUpdates(to: OperationQueue.current!, withHandler: { (data, error) in
            print("\(self.manager!.accelerometerData?.acceleration.x),\(self.manager!.accelerometerData?.acceleration.y),\(self.manager!.accelerometerData?.acceleration.z),\(self.manager!.gyroData?.rotationRate.x),\(self.manager!.gyroData?.rotationRate.y),\(self.manager!.gyroData?.rotationRate.z)")
        })
        
        
        
        
        
        
//        //开启加速度更新
//        manager?.startAccelerometerUpdates()
//        //开启螺旋仪更新
//        manager?.startGyroUpdates()
//        //开启状态更新
//        manager?.startDeviceMotionUpdates()
//        //创建定时器
//        let timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updata), userInfo: nil, repeats: true)
//        timer.fireDate = Date.distantPast
    }
    
    func updata() {
        //获取数据
        print("\(manager!.accelerometerData?.acceleration.x),\(manager!.accelerometerData?.acceleration.y),\(manager!.accelerometerData?.acceleration.z),\(manager!.gyroData?.rotationRate.x),\(manager!.gyroData?.rotationRate.y),\(manager!.gyroData?.rotationRate.z)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    


}

