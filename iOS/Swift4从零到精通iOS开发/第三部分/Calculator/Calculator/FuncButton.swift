//
//  FuncButton.swift
//  Calculator
//
//  Created by vip on 16/10/31.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class FuncButton: UIButton {
    
    init() {
        //要使用自动布局 这里的frame设置为(0,0,0,0)
        super.init(frame: CGRect.zero)
        //为按钮添加边框
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = UIColor(red: 219/255.0, green: 219/255.0, blue: 219/255.0, alpha: 1).cgColor
        //设置字体与字体颜色
        self.setTitleColor(UIColor.orange, for: UIControlState.normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        self.setTitleColor(UIColor.black, for: UIControlState.highlighted)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
