//
//  ViewController.swift
//  NotificaitonTest
//
//  Created by jaki on 2018/4/10.
//  Copyright © 2018年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @objc func noti(n:Notification) {
        print(n.userInfo as Any)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(noti(n:)), name: NSNotification.Name(rawValue: "noti"), object: nil)
    }
//    let noti = Notification(name: Notification.Name(rawValue: "notification"), object: nil, userInfo: nil)
//    let noti2 = Notification(name: Notification.Name(rawValue: "notification2"), object: nil, userInfo: ["key":"value"])
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let noti = Notification(name: Notification.Name(rawValue: "noti"), object: nil, userInfo: ["message":"HeeloWorld"])
        NotificationCenter.default.post(noti)

    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

