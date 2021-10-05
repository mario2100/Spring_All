//
//  ViewController.swift
//  UIAlertControllerTest
//
//  Created by vip on 16/9/8.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBOutlet weak var popAlert: UIButton!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func popAlert(_ sender: AnyObject) {
        let alertController = UIAlertController(title: "我是警告框弹窗", message: "这里填写内容", preferredStyle: .alert)
        let alertAction1 = UIAlertAction(title: "登录", style: .default) { (action) in
            print(alertController.textFields?.first?.text ?? "未输入文字")
        }
        let alertAction2 = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        
        alertController.addAction(alertAction1)
        alertController.addAction(alertAction2)
        alertController.addTextField { (textField) in
            textField.placeholder = "请输入用户名"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "请输入密码"
            //密码模式
            textField.isSecureTextEntry = true
        }
        self .present(alertController, animated: true, completion: nil)
    }

    @IBAction func popSheet(_ sender: AnyObject) {
        //使用弹窗风格的警告控制器
        let alertController = UIAlertController(title: "我是抽屉弹窗", message: "这里填写内容", preferredStyle: .actionSheet)
        let alertAction1 = UIAlertAction(title: "确定", style: .default) { (action) in
            print(alertController.textFields?.first?.text ?? "未输入文字")
        }
        let alertAction2 = UIAlertAction(title: "取消", style: .cancel, handler: nil)
       
        alertController.addAction(alertAction1)
        alertController.addAction(alertAction2)
        self .present(alertController, animated: true, completion: nil)
    }

}

