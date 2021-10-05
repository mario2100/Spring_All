//
//  ViewController.swift
//  UIActionSheetTest
//
//  Created by vip on 16/12/21.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIActionSheetDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let actionSheet = UIActionSheet(title: "标题", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: "删除",otherButtonTitles:"确定")
        actionSheet.show(in: self.view)
    }
    func actionSheet(_ actionSheet: UIActionSheet, clickedButtonAt buttonIndex: Int) {
        print("click")
    }

}

