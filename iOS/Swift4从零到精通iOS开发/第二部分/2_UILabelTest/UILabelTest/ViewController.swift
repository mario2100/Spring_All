//
//  ViewController.swift
//  UILabelTest
//
//  Created by vip on 16/8/4.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //创建UILabel控件对象
        let label = UILabel(frame: CGRect(x: 20, y: 20, width: 200, height: 30))
        //设置文本
        label.text = "我是一个普通的便签控件"
        //将其添加到当前视图上
        self.view.addSubview(label)
        
        //创建自定义的UILabel控件对象
        let label2 = UILabel(frame: CGRect(x: 20, y: 60, width: 200, height: 30))
        //设置文本
        label2.text = "我是一个自定义的便签控件"
        //设置字体 这里设置为字号20 加粗的系统字体
        label2.font = UIFont.boldSystemFont(ofSize: 20)
        //设置字体颜色
        label2.textColor = UIColor.red
        //设置阴影颜色
        label2.shadowColor = UIColor.green
        //设置阴影的位置偏移
        label2.shadowOffset = CGSize(width: 2, height: 2)
        //设置文字对齐模式
        label2.textAlignment = NSTextAlignment.center
        //将其添加到当前视图上
        self.view.addSubview(label2)
        
        
        //创建自定义的UILabel控件对象
        let label3 = UILabel(frame: CGRect(x: 20, y: 110, width: 200, height: 150))
        //设置文本
        label3.text = "我是长文本我是长文本我是长文本我是长文本我是长文本我是长文本我是长文本我是长文本我是长文本我是长文本我是长文本我是长文本我是长文本我是长文本我是长文本我是长文本"
        //设置显示行数
        label3.numberOfLines = 7;
        self.view.addSubview(label3)
        
        //创建UILabel控件对象
        let label4 = UILabel(frame: CGRect(x: 20, y: 290, width: 200, height: 30))
        //设置个性化文本
        let attri = NSMutableAttributedString(string: "我是个性化文本")
        attri.addAttributes([NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 20),NSAttributedStringKey.foregroundColor:UIColor.red], range: NSRange(location: 0, length: 2))
        attri.addAttributes([NSAttributedStringKey.font:UIFont.systemFont(ofSize: 13),NSAttributedStringKey.foregroundColor:UIColor.blue], range: NSRange(location: 3, length: 3))
        label4.attributedText = attri;
        //将其添加到当前视图上
        self.view.addSubview(label4)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

