//
//  ViewController.swift
//  UIViewControllerTest
//
//  Created by vip on 16/12/11.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit
var tip = 0
class ViewController: UIViewController {

    //从xib文件进行初始化
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        tip+=1
        print("init:\(tip)")
    }
    //从归档进行初始化
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tip+=1
        print("init?:\(tip)")
    }
    //从xib加载
    override func awakeFromNib() {
        super.awakeFromNib()
        tip+=1
        print("awakeFromNib:\(tip)")
    }
    //加载视图
    override func loadView() {
        super.loadView()
        tip+=1
        print("loadView:\(tip)")
    }
    //加载视图完成
    override func viewDidLoad() {
        super.viewDidLoad()
        tip+=1
        print("viewDidLoad:\(tip)")
    }
    //将要布局子视图
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tip+=1
        print("viewWillLayoutSubviews:\(tip)")
    }
    //完成布局子视图
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tip+=1
        print("viewDidLayoutSubviews:\(tip)")
    }
    //收到内存警告
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        tip+=1
        print("didReceiveMemoryWarning:\(tip)")
    }
    //视图将要展示
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tip+=1
        print("viewWillAppear:\(tip)")
    }
    //视图完成展示
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tip+=1
        print("viewDidAppear:\(tip)")
    }
    //视图将要消失
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tip+=1
        print("viewWillDisappear:\(tip)")
    }
    //视图已经消失
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tip+=1
        print("viewDidDisappear:\(tip)")
    }
    //析构方法
    deinit {
        tip+=1
        print("deinit:\(tip)")
    }
}

