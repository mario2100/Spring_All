//
//  ViewController.swift
//  ThreadTest
//
//  Created by jaki on 2018/4/10.
//  Copyright © 2018年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @objc func newThread() {
        for i in 0..<10 {
            print("子线程:",Thread.current,i)
        }
        //结束当前线程
        Thread.exit()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        Thread.detachNewThreadSelector(#selector(newThread), toTarget: self, with: nil)
        for i in 0..<10 {
            print("主线程:",Thread.current,i)
        }

        self.performSelector(inBackground: <#T##Selector#>, with: <#T##Any?#>)
        
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

