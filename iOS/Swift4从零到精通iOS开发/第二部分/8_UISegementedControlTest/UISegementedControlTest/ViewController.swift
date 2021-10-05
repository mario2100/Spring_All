//
//  ViewController.swift
//  UISegementedControlTest
//
//  Created by vip on 16/8/15.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //创建分部控制器实例
        let segmentedControl = UISegmentedControl(items: ["1","按钮","按钮按钮","按钮按钮按钮"])
        //设置控件位置与尺寸
        segmentedControl.frame = CGRect(x: 100, y: 100, width: 200, height: 30)
        //设置控件风格颜色
        segmentedControl.tintColor = UIColor.blue
        //添加到当前视图
        self.view.addSubview(segmentedControl)
        
//        segmentedControl.setWidth(8, forSegmentAt: 0)
//        segmentedControl.setWidth(32, forSegmentAt: 1)
//        segmentedControl.setWidth(85, forSegmentAt: 3)
        segmentedControl.apportionsSegmentWidthsByContent  = true
        
//        //添加用户交互
//        segmentedControl.addTarget(self, action: #selector(sele), for: UIControlEvents.valueChanged)
//        
//        //向SegmentedControl中插入新的文字item
//        segmentedControl.insertSegment(withTitle: "按钮5", at: 0, animated: true)
//        //向SegmentedControl中插入新的图片item
//        segmentedControl.insertSegment(with: UIImage(named: "image")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), at: 4, animated: true)
//        
//        //删除某个位置的item
//        segmentedControl.removeSegment(at: 0, animated: true)
//        //删除所有item
////        segmentedControl.removeAllSegments()
//        
//        //修改某个item的图片
//        segmentedControl.setImage(UIImage(named: "image")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal), forSegmentAt: 1)
//        //修改某个item的标题
//        segmentedControl.setTitle("new", forSegmentAt: 1)
    }
    
    
    func sele(seg:UISegmentedControl)  {
        print("选择了\(seg.selectedSegmentIndex)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

