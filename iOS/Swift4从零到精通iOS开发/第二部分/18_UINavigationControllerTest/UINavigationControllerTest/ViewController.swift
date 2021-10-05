//
//  ViewController.swift
//  UINavigationControllerTest
//
//  Created by vip on 16/9/4.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "第2个视图控制器"
        let item = UIBarButtonItem(title: "Pop", style: UIBarButtonItemStyle.plain, target: self, action: #selector(pop))
        self.navigationItem.rightBarButtonItem = item
    }

    func pop()  {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
