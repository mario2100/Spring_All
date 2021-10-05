//
//  ViewController.swift
//  BreakPointTest
//
//  Created by jaki on 2018/4/10.
//  Copyright © 2018年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        var count = 0
//        for i  in 0..<10 {
//            let a = 0
//            let b = a+i
//            count = a+b
//            print(count)
//        }
        let array = [1,2,3,4]
        for i  in 0..<5 {
           
            print(array[i])
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

