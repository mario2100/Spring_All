//
//  ViewController.swift
//  UIViewControllerTest2
//
//  Created by vip on 16/8/29.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var label:UILabel?
    override func viewDidLoad() {
        super.viewDidLoad()
        label = UILabel(frame: CGRect(x: 20, y: 100, width: 280, height: 30))
        self.view.addSubview(label!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func touch(_ sender: AnyObject) {
        let viewController = ViewControllerTwo(data: "这是从第一个界面传递进来的数据")
        //对闭包进行赋值
        viewController.closure = {(data:String) in
            self.label?.text = data
        }
        //设置代理
//        viewController.delegate=self
        self.present(viewController, animated: true, completion: nil)
    }
    
//    func sentedData(data: String) {
//        //进行label的赋值
//        self.label?.text = data
//    }

}

