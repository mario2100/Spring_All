//
//  ViewController.swift
//  NSURLConnectionTest
//
//  Created by vip on 17/1/10.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController,NSURLConnectionDataDelegate{

    var data:Data?
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "http://route.showapi.com/341-1?showapi_appid=58027&showapi_sign=74b9fcd59b844b98b6427da974f4e2e9")
        var request = URLRequest(url: url!)
//        let data = try? NSURLConnection.sendSynchronousRequest(request, returning: nil)
//        let dataString = String(data: data!, encoding: .utf8)
//        print(dataString!)
//        NSURLConnection.sendAsynchronousRequest(request, queue: .main) { (response, data, error) in
//            let dataStr = String(data: data!, encoding: .utf8)
//            print(dataStr!)
//        }
//        print("异步进行网络请求")
        let _ = NSURLConnection(request: request, delegate: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func connection(_ connection: NSURLConnection, didReceive response: URLResponse) {
        print("开始接收数据")
        self.data = Data()
    }
    
    func connection(_ connection: NSURLConnection, didReceive data: Data) {
       self.data?.append(data)
    }
    func connectionDidFinishLoading(_ connection: NSURLConnection) {
        print("接收数据完成")
        let dataStr = String(data: self.data!, encoding: .utf8)
        print(dataStr!)
    }
    
    

    
}

