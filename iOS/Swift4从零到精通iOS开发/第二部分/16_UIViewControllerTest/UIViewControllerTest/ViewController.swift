//
//  ViewController.swift
//  UIViewControllerTest
//
//  Created by vip on 16/8/29.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //加载视图时调用的方法
    override func loadView() {
        super.loadView()
    }
    //视图加载完成时调用的方法
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //将要布局子视图时调用的方法
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    //已经布局子视图时调用的方法
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    //界面将要展现时调用的方法
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    //界面已经展现时调用的方法
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    //界面将要消失时调用的方法
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    //界面已经消失时调用的方法
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    //析构方法
    deinit {
        print("deinit")
        
    }
    //收到内存警告时调用的方法
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func goto(_ sender: AnyObject) {
        self.present(UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!, animated: true, completion: nil)
    }

    @IBAction func goBack(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var goto: UIButton!
}

