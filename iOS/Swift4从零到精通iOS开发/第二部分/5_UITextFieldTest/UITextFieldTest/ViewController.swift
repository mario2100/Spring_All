//
//  ViewController.swift
//  UITextFieldTest
//
//  Created by vip on 16/8/8.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        //创建UITextField实例 并且设置位置为尺寸
        let textField = UITextField(frame: CGRect(x: 20, y: 30, width: 200, height: 30))
        //设置输入框边框风格
        textField.borderStyle = UITextBorderStyle.roundedRect
        //设置文字颜色
        textField.textColor = UIColor.red
        //设置文字对齐方式
        textField.textAlignment = NSTextAlignment.center
        //设置提示文字
        textField.placeholder  = "请输入姓名"
        //将输入框控件添加到当前视图上
        self.view.addSubview(textField)
        
        //创建左视图
        let imageView1 = UIImageView(image: UIImage(named: "image"))
        imageView1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        //创建右视图
        let imageView2 = UIImageView(image: UIImage(named: "image"))
        imageView2.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
//        //设置UITextField控件的左右视图
//        textField.leftView = imageView1
//        textField.rightView = imageView2
//        //设置UITextField控件的左右视图显示模式
//        textField.leftViewMode = UITextFieldViewMode.always
//        textField.rightViewMode = UITextFieldViewMode.always
        
        textField.delegate = self
        
        textField.clearButtonMode = UITextFieldViewMode.always
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //这个方法在输入框即将进入编辑状态时被调用
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    //这个方法在输入框已经开始编辑时被调用
    func textFieldDidBeginEditing(_ textField: UITextField){
        
    }
    //这个方法在输入框即将结束编辑时被调用
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool{
        return true
    }
    //这个方法在输入框已经结束编辑时被调用
    func textFieldDidEndEditing(_ textField: UITextField){
        
    }
    //这个方法在输入框中文本发生变化时被调用
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        //如果输入框中的文字已经等于11位 则不允许在输入
        if (textField.text?.characters.count)! >= 11 {
            return false
        }
        //只有0-9之间的数字可以输入
        if string.characters.first!>="0" && string.characters.first!<="9" {
            return true
        }else{
            return false
        }
        
    }
    //这个方法用户点击输入框中清除按钮会被调用
    func textFieldShouldClear(_ textField: UITextField) -> Bool{
        return true
    }
    //这个方法用户点击键盘上Return按钮会被调用
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }

}

