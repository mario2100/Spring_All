//
//  ViewController.swift
//  UISegmentedControlTest
//
//  Created by vip on 16/12/14.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let seg = UISegmentedControl(items: ["one","","three","four"])
        seg.frame = CGRect(x: 20, y: 100, width: 280, height: 30)
        seg.setImage(UIImage(named: "image")?.withRenderingMode(.alwaysOriginal), forSegmentAt: 1)
        seg.setContentOffset(CGSize(width: 10, height: 10), forSegmentAt: 1)
        seg.isMomentary = true
        self.view.addSubview(seg)
        
//        seg.insertSegment(withTitle: "new", at: 2, animated: true)
//        seg.removeSegment(at: 1, animated: true)
//        seg.setTitle("replace", forSegmentAt: 1)
//        seg.removeAllSegments()
//        seg.setWidth(130, forSegmentAt: 3)
        seg.apportionsSegmentWidthsByContent = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

