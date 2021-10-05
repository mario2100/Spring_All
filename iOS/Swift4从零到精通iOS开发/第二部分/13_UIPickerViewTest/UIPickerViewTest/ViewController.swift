//
//  ViewController.swift
//  UIPickerViewTest
//
//  Created by vip on 16/8/23.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource{

    override func viewDidLoad() {
        super.viewDidLoad()
        //创建选择器控件实例
        let pickerView = UIPickerView(frame: CGRect(x: 20, y: 100, width: 280, height: 200))
        //设置代理
        pickerView.delegate = self
        //设置数据源
        pickerView.dataSource = self
        //将选择器控件添加到当前视图上
        self.view.addSubview(pickerView)
    }
    
    
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "第\(component+1)组第\(row)行"
    }

    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        //创建属性字符串
        let attri = NSMutableAttributedString(string: "第\(component+1)组第\(row)行")
        //为属性字符串添加背景颜色属性
        attri.addAttributes([NSForegroundColorAttributeName:UIColor.red], range: NSRange(location: 0, length: attri.length))
        return attri
    }
    
//    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
//        let view = UIImageView(image: UIImage(named: "image"))
//        view.frame = CGRect(x: 0, y: 0, width: 110, height: 30)
//        return view
//    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("用户选择了\(component)组\(row)行")
    }
    
    //设置选择器控件各个组的行宽
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        if component==0 {
            return 180
        }else{
            return 100
        }
    }
    
    //设置选择控件的行高
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 20
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

