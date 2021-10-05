//
//  MyRequestManager.swift
//  MyRequestConnect
//
//  Created by vip on 17/1/11.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit

class MyRequestManager: NSObject {
    var HTTPHeadersDic:Dictionary<String,String>?
    var requestConnectionArray:Array<MyRequestConnection>?
    private static let shared = MyRequestManager()
    static func sharedManager()->MyRequestManager{
        return shared
    }
    func addRequestToManager(urlStr:String,finish:@escaping (Bool,Data)->Void) {
        for connection in requestConnectionArray!{
            if connection.urlStr! == urlStr {
                return
            }
        }
        let connection = MyRequestConnection()
        if let dic = HTTPHeadersDic {
            connection.HTTPHeadersDic = dic
        }
        requestConnectionArray?.append(connection)
        connection.startRequest(url: urlStr) { (success, data) in
            let index = self.requestConnectionArray!.index(of: connection)
            self.requestConnectionArray?.remove(at: index!)
            finish(success,data)
        }
    }
    override init() {
        super.init()
        requestConnectionArray = Array<MyRequestConnection>()
    }
}
