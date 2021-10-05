//
//  ViewController.swift
//  CBCentralManagerTest
//
//  Created by vip on 17/3/5.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit
import CoreBluetooth
class ViewController: UIViewController,CBCentralManagerDelegate,CBPeripheralDelegate {
    //中心设备管理对象
    private var centerManager:CBCentralManager?
    //要连接的外设
    private var peripheral:CBPeripheral?
    //要交互的外设属性
    private var chara:CBCharacteristic?
    private var messageLabel:UILabel?
    override func viewDidLoad() {
        super.viewDidLoad()
        centerManager = CBCentralManager(delegate: self, queue: DispatchQueue.global(qos:.userInitiated))
        self.creatView()
    }
    func creatView() {
        messageLabel = UILabel(frame: CGRect(x: 20, y: 100, width: self.view.frame.width-40, height: 30))
        messageLabel?.backgroundColor = UIColor.green
        messageLabel?.textColor = UIColor.red
        messageLabel?.textAlignment = .center
        self.view.addSubview(messageLabel!)
    }
    //设备硬件检测状态回调的方法 可用后开始扫描设备
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if centerManager!.state == .poweredOn {
            centerManager!.scanForPeripherals(withServices: nil, options: nil)
        }
    }
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        //获取设备的名称 或者广告中的相应字段来配对
        let name = advertisementData[CBAdvertisementDataLocalNameKey] as! String
        if name == "ZYH" {
            //保存此设备
            self.peripheral = peripheral
            //进行连接
            centerManager?.connect(peripheral, options: [CBConnectPeripheralOptionNotifyOnConnectionKey:NSNumber(value: true)])
        }
    }
    //连接断开
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("连接断开")
        centerManager!.connect(peripheral, options: [CBConnectPeripheralOptionNotifyOnConnectionKey:NSNumber(value: true)])
    }
    //连接设备失败回调的方法
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("连接失败")
    }
    //连接外设成功的回调
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("连接成功")
        //设置代理与搜索外设中的服务
        peripheral.delegate = self
        peripheral.discoverServices(nil)
    }
    //发现服务后回调的方法
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
       if let sers=peripheral.services {
            for service in sers {
                //发现服务 比较服务的UUID
                if service.uuid.isEqual(CBUUID(string: "68753A44-4D6F-1226-9C60-0050E4C00067")) {
                    //查找服务中的特征值
                    peripheral .discoverCharacteristics(nil, for: service)
                    break
                }
            }
        }
    }
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if let chas = service.characteristics{
            for characteristic in chas {
                //发现特征 比较特征值的UUID来获取所需要的
                if characteristic.uuid.isEqual(CBUUID(string: "68753A44-4D6F-1226-9C60-0050E4C00067")) {
                    //保存特征值
                    chara = characteristic
                    //监听特征值
                    peripheral.setNotifyValue(true, for: characteristic)
                }
            }
        }
    }
    //所监听的特征值更新时回调的方法
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        //要在主线程中刷新
        DispatchQueue.main.async {
            self.messageLabel?.text = String(data: characteristic.value!, encoding: .utf8)
        }
    }
    
}

