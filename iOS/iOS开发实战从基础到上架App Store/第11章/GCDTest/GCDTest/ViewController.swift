//
//  ViewController.swift
//  GCDTest
//
//  Created by jaki on 2018/4/10.
//  Copyright © 2018年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let queue = DispatchQueue(label: "myQueue")
        queue.sync {
            for i in 0..<10 {
                print("1:",Thread.current,i)
            }
        }
        print("任务1")
        queue.async {
            for i in 0..<10 {
                print("2",Thread.current,i)
            }
        }
        print("任务2")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

