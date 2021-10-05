//
//  ViewController.swift
//  AutoTextView
//
//  Created by vip on 16/10/14.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextViewDelegate {

    var textView:UITextView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView = UITextView()
        //设置边框
        textView?.layer.borderWidth = 1
        textView?.layer.borderColor = UIColor.gray.cgColor
        textView?.delegate = self
        self.view.addSubview(textView!)
        textView?.snp.makeConstraints({ (make) in
            make.leading.equalTo(100)
            make.trailing.equalTo(-100)
            make.top.equalTo(150)
            make.height.equalTo(30)
        })
    }
 
    //监听用户输入
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView.bounds.size.height>=100 {
            if textView.contentSize.height < textView.bounds.size.height {
                textView.snp.updateConstraints({ (remake) in
                    remake.height.equalTo(textView.contentSize.height)
                })
            }
        }
        if (textView.contentSize.height != textView.bounds.size.height) && textView.bounds.size.height<100 {
            textView.snp.updateConstraints({ (reMake) in
                reMake.height.equalTo(textView.contentSize.height)
            })
            //将布局变化过程使用动画过渡
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        return true

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

