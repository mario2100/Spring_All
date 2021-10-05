//
//  ViewController.swift
//  UINavigationControllerTest
//
//  Created by vip on 16/12/22.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit
var conIndex = 1
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "第\(conIndex)视图控制器"
        conIndex+=1
        let btn = UIButton(type: .system)
        btn.frame = CGRect(x: 20, y: 100, width: 280, height: 30)
        btn.setTitle("push", for: .normal)
        btn.addTarget(self, action: #selector(push), for: .touchUpInside)
        self.view.addSubview(btn)
        
        self.navigationController?.navigationBar.barTintColor = UIColor.purple
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named:"image"), for: .default)
        
        let btnItem1 = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(click))
         let btnItem2 = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(click))
        self.navigationItem.leftBarButtonItems = [btnItem1,btnItem2]
//        self.navigationItem.backBarButtonItem = btnItem1
        let item1 = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(click))
//        let item2 = UIBarButtonItem(customView: UIView())
//        let item3 = UIBarButtonItem(image: UIImage(named: "image"), style: .plain, target: self, action: #selector(click))
        let item4 = UIBarButtonItem(title: "标题", style: .plain, target: self, action: #selector(click))
        self.navigationController?.isToolbarHidden = false
        self.navigationController?.toolbar.barTintColor = UIColor.red
        self.toolbarItems = [item1,item4]
        
        self.navigationController?.hidesBarsWhenVerticallyCompact = true
        self.navigationController?.hidesBarsOnTap=true
        self.navigationController?.hidesBarsWhenKeyboardAppears=true
        self.navigationController?.hidesBarsOnSwipe=true

    }
    func click()  {
        
    }
    func push() {
        let con = ViewController()
        con.title = "第\(conIndex)视图控制器"
        self.navigationController?.pushViewController(con, animated: true)
    }
    deinit {
        conIndex-=1
    }
}

