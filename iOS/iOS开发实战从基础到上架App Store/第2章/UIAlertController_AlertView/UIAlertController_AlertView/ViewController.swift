//
//  ViewController.swift
//  UIAlertController_AlertView
//
//  Created by vip on 16/12/19.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let alertView = UIAlertController(title: "标题", message: "警告的内容", preferredStyle: .alert)
        let action = UIAlertAction(title: "按钮", style: .default, handler:{ (UIAlertAction) -> Void in
            print("click")
        })
        let action2 = UIAlertAction(title: "取消", style: .cancel, handler:{ (UIAlertAction) -> Void in
            print("取消")
        })
        let action3 = UIAlertAction(title: "注意", style: .destructive, handler:{ (UIAlertAction) -> Void in
            print("注意")
        })
        alertView.addAction(action)
        alertView.addAction(action2)
        alertView.addAction(action3)
        alertView.addTextField { (textfield) in
            textfield.placeholder = "place"
        }
        self.present(alertView, animated: true, completion: nil)
    }


}

