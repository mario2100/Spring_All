//
//  BlueToothTool.swift
//  BlueGame
//
//  Created by vip on 17/3/12.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit
import CoreBluetooth
protocol BlueToothToolDelegate {
    //获取对方数据
    func getData(data:String)
}
class BlueToothTool: NSObject,CBPeripheralDelegate,CBPeripheralManagerDelegate,UIAlertViewDelegate,CBCentralManagerDelegate {
    //代理
    var delegate:BlueToothToolDelegate?
    //标记是否为房主
    var isCentral = false
    //获取单例对象
    static func sharedManager()->BlueToothTool{
        struct Static {
            static let instance = BlueToothTool()
        }
        return Static.instance
    }
    //作为游戏的房主建立游戏房间
    func setUpGame(name:String,finish:@escaping (Bool)->Void) {
        block = finish
        if peripheralManager == nil {
            //初始化服务
            ser = CBMutableService(type: CBUUID(string: "68753A44-4D6F-1226-9C60-0050E4C00067"), primary: true)
            //初始化特征
            readChara = CBMutableCharacteristic(type: CBUUID(string: "68753A44-4D6F-1226-9C60-0050E4C00067"), properties: .notify, value: nil, permissions: .readable)
            writeChara = CBMutableCharacteristic(type: CBUUID(string: "68753A44-4D6F-1226-9C60-0050E4C00068"), properties: .writeWithoutResponse, value: nil, permissions: .writeable)
            //向服务中添加特性
            ser?.characteristics = [readChara!,writeChara!]
            peripheralManager = CBPeripheralManager(delegate: self, queue: DispatchQueue.global(qos:.userInteractive))
        }
        //设置为房主
        isCentral = true
        //开始广播广告
        peripheralManager?.startAdvertising([CBAdvertisementDataLocalNameKey:"WUZIGame"])
    }
    //作为游戏的加入者查找附近的游戏
    func searchGame()  {
        if centerManager==nil {
            centerManager = CBCentralManager(delegate: self, queue: DispatchQueue.main)
        }else{
            centerManager?.scanForPeripherals(withServices: nil, options: nil)
            if searchGameView == nil {
                searchGameView = UIView(frame: CGRect(x: UIScreen.main.bounds.size.width/2-100, y: 240, width: 200, height: 100))
                let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
                label.backgroundColor = UIColor.clear
                label.textAlignment = .center
                label.text = "正在扫描加入附近游戏"
                searchGameView?.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
                searchGameView?.addSubview(label)
                UIApplication.shared.delegate?.window??.addSubview(self.searchGameView!)
            }else{
                searchGameView?.removeFromSuperview()
                UIApplication.shared.delegate?.window??.addSubview(self.searchGameView!)
            }
        }
        //设置为游戏加入方
        isCentral = false
    }
    //设备硬件检测状态回调的方法 可用后开始扫描设备
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if centerManager!.state == .poweredOn {
            centerManager?.scanForPeripherals(withServices: nil, options: nil)
            if searchGameView==nil {
                DispatchQueue.main.async {
                    self.searchGameView = UIView(frame: CGRect(x: UIScreen.main.bounds.width/2-100, y: 240, width: 200, height: 100))
                    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
                    label.backgroundColor = UIColor.clear
                    label.textAlignment = .center
                    label.text = "正在扫描接入附近游戏"
                    self.searchGameView?.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
                    self.searchGameView?.addSubview(label)
                    UIApplication.shared.delegate?.window??.addSubview(self.searchGameView!)
                }
            }else{
                DispatchQueue.main.async {
                    self.searchGameView?.removeFromSuperview()
                    UIApplication.shared.delegate?.window??.addSubview(self.searchGameView!)
                }
            }
        }else{
            DispatchQueue.main.async {
                self.showAlert()
            }
        }
    }
    //发现外设后的回调方法
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        let name = advertisementData[CBAdvertisementDataLocalNameKey] as! String
        if name == "WUZIGame" {
            //保存此设备
            self.peripheral = peripheral
            //进行连接
            centerManager?.connect(peripheral, options: [CBConnectPeripheralOptionNotifyOnConnectionKey:NSNumber(value:true)])
        }
        
    }
    //连接外设成功的回调
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("连接成功")
        //设置代理与搜索外设中的服务
        peripheral.delegate = self
        peripheral.discoverServices(nil)
        DispatchQueue.main.async {
            self.searchGameView?.removeFromSuperview()
        }
        
    }
    //连接断开
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("连接断开")
        centerManager?.connect(peripheral, options: [CBAdvertisementDataLocalNameKey:NSNumber(value: true)])
    }
    //发现服务后回调的方法
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        for service in peripheral.services! {
            //发现服务 比较服务的UUID
            if service.uuid.isEqual(CBUUID(string: "68753A44-4D6F-1226-9C60-0050E4C00067")) {
                //查找服务中的特征值
                peripheral.discoverCharacteristics(nil, for: service)
                break
            }
        }
    }
    //发现服务中特征值后回调的方法
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        for characteristic in service.characteristics! {
            //发现特征 比较特征值的UUID
            if characteristic.uuid.isEqual(CBUUID(string: "68753A44-4D6F-1226-9C60-0050E4C00067")) {
                //保存特征值
                centerReadChara = characteristic
                //监听特征值
                peripheral.setNotifyValue(true, for: centerReadChara!)
            }
            if characteristic.uuid.isEqual(CBUUID(string: "68753A44-4D6F-1226-9C60-0050E4C00068")) {
                centerWriteChara = characteristic
            }
        }
    }
    //所监听的特征值更新时回调的方法
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        DispatchQueue.main.async {
            self.delegate?.getData(data: String(data: characteristic.value!, encoding: .utf8)!)
        }
    }
    //断开连接
    func disConnect()  {
        if isCentral {
            centerManager?.cancelPeripheralConnection(peripheral!)
            peripheral?.setNotifyValue(false, for: centerReadChara!)
        }
    }
    //进行写数据操作
    func writeData(data:String) {
        if isCentral {
            peripheralManager?.updateValue(data.data(using: .utf8)!, for: readChara!, onSubscribedCentrals: nil)
        }else{
            peripheral?.writeValue(data.data(using: .utf8)!, for: centerWriteChara!, type: .withoutResponse)
        }
    }
    //外设管理中心
    private var peripheralManager:CBPeripheralManager?
    //外设提供的服务
    private var ser:CBMutableService?
    //服务提供的读特征值
    private var readChara:CBMutableCharacteristic?
    //服务提供的写特征值
    private var writeChara:CBMutableCharacteristic?
    //等待对方加入的提示视图
    private var waitOtherView:UIView?
    //正在扫描附近游戏的提示视图
    private var searchGameView:UIView?
    //设备中心管理对象
    private var centerManager:CBCentralManager?
    //要连接的外设
    private var peripheral:CBPeripheral?
    //要交互的外设属性
    private var centerReadChara:CBCharacteristic?
    private var centerWriteChara:CBCharacteristic?
    //处理开始游戏的回调
    private var block:((Bool)->Void)?
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        //判断是否可用
        if peripheral.state == .poweredOn {
            //添加服务
            peripheralManager!.add(ser!)
            //开始广播
            peripheralManager?.startAdvertising([CBAdvertisementDataLocalNameKey:"WUZIGame"])
        }else{
            //弹框提示
            DispatchQueue.main.async {
                self.showAlert()
            }
        }
    }
    func showAlert()  {
        let alert = UIAlertView(title: "温馨提示", message: "请确保您的蓝牙可用", delegate: nil, cancelButtonTitle: "好的")
        alert.show()
    }
    //开始放广告的回调
    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
        if waitOtherView == nil {
            waitOtherView = UIView(frame: CGRect(x: UIScreen.main.bounds.width/2-100, y: 240, width: 200, height: 100))
            DispatchQueue.main.async {
                let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
                label.backgroundColor = UIColor.clear
                label.textAlignment = .center
                label.text = "等待附近玩家接入"
                self.waitOtherView?.addSubview(label)
                self.waitOtherView?.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
                UIApplication.shared.delegate?.window??.addSubview(self.waitOtherView!)
            }
        }else{
            DispatchQueue.main.async {
                self.waitOtherView?.removeFromSuperview()
                UIApplication.shared.delegate?.window??.addSubview(self.waitOtherView!)
            }
        }
    }
    //中心设备订阅特征值时的回调
    func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didSubscribeTo characteristic: CBCharacteristic) {
        peripheralManager?.stopAdvertising()
        if isCentral {
            let alert = UIAlertView(title: "", message: "请选择先手后手", delegate: self, cancelButtonTitle: "我先手", otherButtonTitles: "我后手", "")
            DispatchQueue.main.async {
                self.waitOtherView?.removeFromSuperview()
                alert.show()
            }
        }
    }
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        //告诉开发者先后手信息
        if buttonIndex==0 {
            if isCentral {
                block!(true)
            }else{
                block!(false)
            }
        }else{
            if isCentral {
                block!(false)
            }else{
                block!(true)
            }
        }
    }
    //收到写消息后的回调
    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveWrite requests: [CBATTRequest]) {
        DispatchQueue.main.async {
            self.delegate?.getData(data: String(data: requests.first!.value!, encoding: .utf8)!)
        }
    }
    
}
