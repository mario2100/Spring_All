//
//  ViewController.swift
//  OperationTest
//
//  Created by jaki on 2018/4/10.
//  Copyright © 2018年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let operation = BlockOperation {
            for i in 0..<10 {
                 print(Thread.current,i)
            }
        }
        let queue = OperationQueue()
        queue.addOperation(operation)
        for i in 0..<10 {
            print(Thread.current,i)
        }
        DispatchQueue.global(qos: DispatchQoS.QoSClass.background)
//        operation.addExecutionBlock {
//            for i in 0..<10 {
//                print("2:",Thread.current,i)
//            }
//        }
//        operation.addExecutionBlock {
//            for i in 0..<10 {
//                print("3:",Thread.current,i)
//            }
//        }
//        operation.start()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

