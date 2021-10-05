//
//  ViewController.swift
//  UIProgressViewTest
//
//  Created by vip on 16/12/15.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let progressView = UIProgressView(frame: CGRect(x: 20, y: 100, width: 280, height: 30))
        progressView.progressTintColor = UIColor.red
        progressView.trackTintColor = UIColor.blue
        self.view.addSubview(progressView)
        progressView.progress = 0.5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

