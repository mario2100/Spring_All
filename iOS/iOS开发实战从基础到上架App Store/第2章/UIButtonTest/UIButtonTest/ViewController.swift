//
//  ViewController.swift
//  UIButtonTest
//
//  Created by vip on 16/12/13.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        let button = UIButton(type: .system)
        let button = UIButton(type: .custom)
//        button.setBackgroundImage(UIImage(named: "image"), for: .normal)
        button.setImage(UIImage(named: "image"), for: .normal)
        button.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        button.frame = CGRect(x: 40, y: 100, width: 240, height: 30)
        button.backgroundColor = UIColor.red
        button.setTitle("点我一下", for: .normal)
        button.addTarget(self, action: #selector(changeColor), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    func changeColor()  {
        self.view.backgroundColor = UIColor(red: CGFloat(arc4random()%255)/255.0, green: CGFloat(arc4random()%255)/255.0, blue: CGFloat(arc4random()%255)/255.0, alpha: 1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

