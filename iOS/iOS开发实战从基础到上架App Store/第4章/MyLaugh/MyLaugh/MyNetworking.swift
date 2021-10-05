//
//  MyNetworking.swift
//  MyLaugh
//
//  Created by vip on 17/1/13.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit
import Alamofire
class MyNetworking: NSObject {

    var HTTPHeadersDic:Dictionary<String,String>?
    static let sharedNetWorking = MyNetworking()
    class func requestGet(url:String,finish:@escaping (Bool,Data)->Void){
        let urlString = url.addingPercentEscapes(using: .utf8)
        Alamofire.request(urlString!,headers:self.sharedNetWorking.HTTPHeadersDic).responseJSON { (jsonData) in
            if jsonData.data != nil {
                finish(true,jsonData.data!)
            }else{
                finish(false,Data())
            }
        }
    }
    class func requestPost(url:String,param:Dictionary<String,String>,finish:@escaping (Bool,Data)->Void){
        let urlString = url.addingPercentEscapes(using: .utf8)
        Alamofire.request(urlString!,method:.post,parameters:param, headers:self.sharedNetWorking.HTTPHeadersDic).responseJSON { (jsonData) in
            if jsonData.data != nil {
                finish(true,jsonData.data!)
            }else{
                finish(false,Data())
            }
        }
    }
}
