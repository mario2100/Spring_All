//
//  ViewController.swift
//  UIAlertController_ActionSheet
//
//  Created by vip on 16/12/19.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let actionSheet = UIAlertController(title: "标题", message: "内容", preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "one", style: .destructive, handler: {(UIAlertAction) -> Void in
            print("one")
        })
        let action2 = UIAlertAction(title: "two", style: .default, handler: {(UIAlertAction) -> Void in
            print("two")
        })
        let action3 = UIAlertAction(title: "three", style: .cancel, handler: {(UIAlertAction) -> Void in
            print("three")
        })
        actionSheet.addAction(action)
        actionSheet.addAction(action2)
        actionSheet.addAction(action3)
        self.present(actionSheet, animated: true, completion: nil)
    }

}

