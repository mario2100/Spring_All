//
//  ViewController.swift
//  AutolayoutTestFour
//
//  Created by vip on 17/3/22.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.red
        self.view.addSubview(view)
        let constraintArray = NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[view(100@1000)]", metrics: nil, views: ["view":view])
        let constraintArray2 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-100-[view(100)]", metrics: nil, views: ["view":view])
        self.view.addConstraints(constraintArray)
        self.view.addConstraints(constraintArray2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

