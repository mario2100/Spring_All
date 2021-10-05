//
//  ViewController.swift
//  ArchiveTestThree
//
//  Created by vip on 17/3/27.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let obj = Model()
        obj.name = "Jaki"
        obj.age = 24
        //进行归档
        let data = NSKeyedArchiver.archivedData(withRootObject: obj)
        //进行接档
        let obj2 = NSKeyedUnarchiver.unarchiveObject(with: data) as! Model
        print(obj.name!,obj2.age)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

