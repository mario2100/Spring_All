//
//  ViewController.swift
//  UIDatePickerTest
//
//  Created by vip on 16/12/20.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let datePicker = UIDatePicker(frame: CGRect(x: 20, y: 100, width: 280, height: 150))
        datePicker.datePickerMode = .time
        datePicker.addTarget(self, action: #selector(selector), for: .valueChanged)
        self.view.addSubview(datePicker)
    }
    
    func selector(datePicker:UIDatePicker)  {
        print(datePicker.date)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

