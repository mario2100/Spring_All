//
//  ViewController.swift
//  SQLiteLibTest
//
//  Created by vip on 16/10/25.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        ObjectiveC_Hander.runNormalSql("create table Student(name text PRIMARY KEY,age integer DEFAULT 15)")
        ObjectiveC_Hander.runNormalSql("insert into Student(name,age) values(\"珲少\",25)")
        ObjectiveC_Hander.selectSql()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

