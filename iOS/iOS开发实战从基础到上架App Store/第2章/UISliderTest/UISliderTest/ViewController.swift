//
//  ViewController.swift
//  UISliderTest
//
//  Created by vip on 16/12/15.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let slider = UISlider(frame: CGRect(x: 20, y: 100, width: 280, height: 30))
        slider.isContinuous = true
        slider.minimumValue = 0
        slider.maximumValue = 10
        slider.minimumTrackTintColor = UIColor.red
        slider.maximumTrackTintColor = UIColor.green
        slider.thumbTintColor = UIColor.blue
        slider.addTarget(self, action: #selector(changeValue), for: .valueChanged)
        self.view.addSubview(slider)
        
        slider.minimumValueImage = UIImage(named: "image")
        slider.maximumValueImage = UIImage(named: "image")
        slider.setThumbImage(UIImage(named: "image"), for: .normal)
    }
    
    func changeValue(slider:UISlider) {
        print(slider.value)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

