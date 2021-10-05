//
//  MyRequestConnection.swift
//  MyRequestConnect
//
//  Created by vip on 17/1/11.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit

class MyRequestConnection: NSObject {
    var HTTPHeadersDic:Dictionary<String,String>?
    var urlStr:String?
    func startRequest(url:String,finish:@escaping (Bool,Data)->Void) {
        urlStr = url
        let u = URL(string: url)
        var request = URLRequest(url: u!)
        if let head = self.HTTPHeadersDic {
            head.forEach({ (dic) in
                request.setValue(dic.value, forHTTPHeaderField: dic.key)
            })
        }
        NSURLConnection.sendAsynchronousRequest(request, queue: .main) { (response, data, error) in
            if error == nil {
                finish(true,data!)
            }else{
                print("网络请求出错")
                finish(false,Data())
            }
        }
    }
}
