//
//  ViewController.swift
//  MyRequestConnect
//
//  Created by vip on 17/1/11.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let manager = MyRequestManager.sharedManager()
        manager.addRequestToManager(urlStr: "http://route.showapi.com/341-1?showapi_appid=58027&showapi_sign=74b9fcd59b844b98b6427da974f4e2e9") { (success, data) in
            if success {
                let dataDic:Dictionary<String,AnyObject> = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! Dictionary<String, AnyObject>
                let model = RootDataModel()
                model.setValuesForKeys(dataDic["showapi_res_body"] as! [String : AnyObject])
                print(model)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

