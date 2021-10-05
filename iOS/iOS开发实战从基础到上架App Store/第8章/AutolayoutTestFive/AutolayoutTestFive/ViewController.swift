//
//  ViewController.swift
//  AutolayoutTestFive
//
//  Created by vip on 17/3/22.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextViewDelegate {
    var textView:UITextView?
    var array1:Array<NSLayoutConstraint>?
    var array2:Array<NSLayoutConstraint>?
    override func viewDidLoad() {
        super.viewDidLoad()
        //进行文本输入框初始化
        textView = UITextView()
        textView?.layer.borderColor = UIColor.gray.cgColor
        textView?.layer.borderWidth = 1
        textView?.translatesAutoresizingMaskIntoConstraints = false
        textView?.delegate = self
        self.view.addSubview(textView!)
        //使用VFL创建约束
        array1 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-100-[textView]-100-|", metrics: nil, views: ["textView":textView!])
        array2 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-150-[textView(30)]", metrics: nil, views: ["textView":textView!])
        //添加约束
        self.view.addConstraints(array1!)
        self.view.addConstraints(array2!)
    }
    //监听textView中文本的变化
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        //当文本高度大于textView的高度并且小于100时 更新约束
        if textView.contentSize.height>textView.frame.height && textView.contentSize.height<100 {
            let height = textView.contentSize.height
            //先删约束
            self.view.removeConstraints(array1!)
            self.view.removeConstraints(array2!)
            //创建新约束
            array1 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-100-[textView]-100-|", metrics: nil, views: ["textView":textView])
            array2 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-150-[textView(height)]", metrics: ["height":height], views: ["textView":textView])
            self.view.addConstraints(array1!)
            self.view.addConstraints(array2!)
        }
        
        self.view.updateConstraintsIfNeeded()
        //更新约束
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
        }
        return true
    }
}

