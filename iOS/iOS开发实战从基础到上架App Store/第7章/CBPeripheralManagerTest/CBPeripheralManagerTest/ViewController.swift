//
//  ViewController.swift
//  CBPeripheralManagerTest
//
//  Created by vip on 17/3/7.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController,CBPeripheralManagerDelegate {
    //外设管理中心
    private var peripheralManager:CBPeripheralManager?
    //外设提供的服务
    private var ser:CBMutableService?
    //服务提供的特征值
    private var chara:CBMutableCharacteristic?
    //输入文本框
    private var textField:UITextField?
    //发送按钮
    private var sentBtn:UIButton?
    override func viewDidLoad() {
        super.viewDidLoad()
        //初始化服务
        ser = CBMutableService(type: CBUUID(string: "68753A44-4D6F-1226-9C60-0050E4C00067"), primary: true  )
        //初始化特征值
        chara = CBMutableCharacteristic(type: CBUUID(string: "68753A44-4D6F-1226-9C60-0050E4C00067"), properties: .notify, value: nil, permissions: .readable)
        //向服务中添加特征
        ser?.characteristics = [chara!]
        //初始化外设管理对象
        peripheralManager = CBPeripheralManager(delegate: self, queue: DispatchQueue.global(qos:.userInteractive))
        self.creatView()
    }
    func creatView() {
        textField = UITextField(frame: CGRect(x: 20, y: 100, width: self.view.frame.width-40, height: 30))
        textField?.borderStyle = .roundedRect
        self.view.addSubview(textField!)
        sentBtn = UIButton(type: .system)
        sentBtn?.frame = CGRect(x: self.view.frame.width/2-30, y: 150, width: 60, height: 30)
        sentBtn?.setTitle("发送", for: .normal)
        sentBtn?.addTarget(self, action: #selector(sent), for: .touchUpInside)
        sentBtn?.isEnabled = false
        self.view.addSubview(sentBtn!)
    }
    func sent()  {
        let data = textField!.text?.data(using: .utf8)
        //将文本框中的文字 更新到特征值中
        peripheralManager!.updateValue(data!, for: chara!, onSubscribedCentrals: nil)
    }
    //设备硬件检测状态回调的方法 可用后 添加服务于广播广告
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        if peripheral.state == .poweredOn {
            //添加服务
            peripheral.add(ser!)
            //开始广播广告
            peripheral.startAdvertising([CBAdvertisementDataLocalNameKey:"ZYH"])
        }
    }
    //添加服务后回调的方法
    func peripheralManager(_ peripheral: CBPeripheralManager, didAdd service: CBService, error: Error?) {
        if error != nil {
            print("添加服务失败")
        }
        print("添加服务完成")
    }
    //开始发广告的回调
    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
        print("播放广告")
    }
    //中心设备订阅特征值时的回调
    func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didSubscribeTo characteristic: CBCharacteristic) {
        //与中心设备订阅成功后 将按钮设置为可用
        sentBtn?.isEnabled = true
        print("订阅特征值")
    }
    //中心设备取消订阅特征值时回调
    func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didUnsubscribeFrom characteristic: CBCharacteristic) {
        sentBtn?.isEnabled = false
        print("取消订阅特征值")
    }
    
    
}

