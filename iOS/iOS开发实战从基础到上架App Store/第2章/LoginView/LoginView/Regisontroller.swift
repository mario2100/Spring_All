//
//  Regisontroller.swift
//  LoginView
//
//  Created by vip on 16/12/21.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class Regisontroller: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        let label = UILabel(frame: CGRect(x: 20, y: 100, width: SCREEN_SIZE.width-40, height: 60))
        label.font = UIFont.systemFont(ofSize: 23)
        label.text = "注册界面"
        label.textAlignment = .center
        self.view.addSubview(label)
        //返回按钮
        let btn = UIButton(type: .system)
        btn.frame = CGRect(x: SCREEN_SIZE.width/2-50, y: 220, width: 100, height: 30)
        btn.setTitle("返回", for: .normal)
        btn.addTarget(self, action: #selector(retu), for: .touchUpInside)
        self.view.addSubview(btn)
    }
    func retu()  {
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
