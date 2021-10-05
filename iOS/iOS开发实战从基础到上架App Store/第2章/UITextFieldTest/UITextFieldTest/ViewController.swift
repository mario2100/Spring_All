//
//  ViewController.swift
//  UITextFieldTest
//
//  Created by vip on 16/12/13.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        let textField = UITextField(frame: CGRect(x: 20, y: 100, width: 280, height: 30))
        textField.borderStyle = .roundedRect
        textField.placeholder = "请输入文字"
        
        textField.textColor = UIColor.red
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.textAlignment = .center
        
        let imageView = UIImageView(image: UIImage(named: "image"))
        textField.leftView = imageView
        textField.leftViewMode = .always
        textField.delegate = self
        self.view.addSubview(textField)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.characters.count>0 {
            let charas:[Character] = ["0","1","2","3","4","5","6","7","8","9"]
            let char = string.characters.first!
            if !charas.contains(char) {
                print("请输入数字")
                return false
            }
            if textField.text!.characters.count+string.characters.count>11 {
                print("超过11位啦")
                return false
            }
        }
        return true
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

