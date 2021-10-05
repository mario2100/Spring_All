//
//  ViewController.swift
//  NoteBook
//
//  Created by vip on 16/11/8.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController,HomeButtonDelegate {

    var homeView:HomeView?
    var dataArray:Array<String>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "点滴生活"
        //取消导航栏对页面布局的影响
        self.edgesForExtendedLayout = UIRectEdge()
        //从DataManager中获取分组数据
        //dataArray = DataManager.getGroupData()
        self.installUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataArray = DataManager.getGroupData()
        self.homeView?.dataArray = dataArray
        self.homeView?.updateLayout()
    }
    func installUI() {
        homeView = HomeView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height-64))
        self.view.addSubview(homeView!)
        homeView!.homeButtonDelegate = self
        homeView?.dataArray = dataArray
        homeView?.updateLayout()
        //进行导航功能按钮的创建
        installNavigationItem()
    }
    
    func homeButtonClick(title:String){
        let controller = NoteListTableViewController()
        controller.name = title
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func installNavigationItem() {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addGroup))
        self.navigationItem.rightBarButtonItem = barButtonItem
    }
    
    func addGroup() {
        let alertController = UIAlertController(title: "添加记事分组", message: "添加的分组名不能与已有分组重复或为空", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "请输入记事分组名称"
        }
        let alertItem = UIAlertAction(title: "取消", style: .cancel, handler: {(UIAlertAction) in
            return
        })
        let alertItemAdd = UIAlertAction(title: "确定", style: .default, handler: {(UIAlertAction) -> Void in
            //进行判断
            var exist = false
            self.dataArray?.forEach({ (element) in
                if element == alertController.textFields?.first!.text || alertController.textFields?.first!.text?.characters.count==0 {
                    exist = true
                }
            })
            if exist {
                return
            }
            self.dataArray?.append(alertController.textFields!.first!.text!)
            self.homeView?.dataArray = self.dataArray
            self.homeView?.updateLayout()
            //将添加的分组写入数据库
            DataManager.saveGroup(name: alertController.textFields!.first!.text!)
            
        })
        alertController.addAction(alertItem)
        alertController.addAction(alertItemAdd)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

