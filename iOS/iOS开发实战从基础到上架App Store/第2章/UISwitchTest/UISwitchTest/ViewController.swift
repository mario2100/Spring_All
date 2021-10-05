//
//  ViewController.swift
//  UISwitchTest
//
//  Created by vip on 16/12/14.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let swi = UISwitch(frame: CGRect(x: 100, y: 100, width: 100, height: 40))
        swi.onTintColor = UIColor.green
        swi.tintColor = UIColor.red
        swi.thumbTintColor = UIColor.orange
        self.view.addSubview(swi)
        
        swi.addTarget(self, action: #selector(changeColor), for: .valueChanged)
    }

    func changeColor(swi:UISwitch) {
        if (swi.isOn) {
            self.view.backgroundColor = UIColor.red;
        }else{
            self.view.backgroundColor = UIColor.white;
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

