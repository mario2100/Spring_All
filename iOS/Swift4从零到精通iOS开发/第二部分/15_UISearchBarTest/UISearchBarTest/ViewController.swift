//
//  ViewController.swift
//  UISearchBarTest
//
//  Created by vip on 16/8/25.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        //进行UISearchBar控件的实例化
        let searchBar = UISearchBar(frame: CGRect(x: 20, y: 100, width: 280, height: 60))
        //设置控件风格
        searchBar.searchBarStyle = UISearchBarStyle.prominent
        //将控件添加到当前视图上
        self.view.addSubview(searchBar)
        //将控件的风格颜色修改为红色
//        searchBar.barTintColor = UIColor.red()
        //将控件背景设置为图片
//        searchBar.backgroundImage = UIImage(named: "image")
        //设置默认用户提示文字
        searchBar.placeholder = "请输入要搜索的文字"
        //设置搜索栏标题
        searchBar.prompt = "搜索"
        //显示控件的取消按钮
//        searchBar.showsCancelButton = true
        //显示控件的书库按钮
//        searchBar.showsBookmarkButton = true
        //显示控件的搜索结果按钮
//        searchBar.showsSearchResultsButton = true
        //显示控件的附件视图
        searchBar.showsScopeBar = true
        //设置附件视图按钮个数和标题
        searchBar.scopeButtonTitles = ["女鞋","男装","男鞋","女装","童装"]
        //设置默认选中的附件视图按钮
        searchBar.selectedScopeButtonIndex = 0
        //由于附件视图会修改搜索栏控件的frame 需要重新设置
        searchBar.frame = CGRect(x: 20, y: 100, width: 280, height: 150)
        
        searchBar.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //搜索栏将要开始编辑时调用的方法 返回false则不允许进入编辑状态 返回true则允许进行编辑状态
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool{
        return true
    }
    //搜索栏已经进入编辑状态时调用的方法
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
    }
    //搜索栏将要结束编辑状态时调用的方法 返回false则不允许结束编辑状态 返回true则允许结束编辑状态
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    //搜索框已经结束编辑状态调用的方法
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    //搜索框中文本已经发生变化时调用的方法
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        
    }
    //搜索框中文本将要发生变化时调用的方法 返回false则此次修改无效
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool{
        return true
    }
    //用户点击键盘搜Search钮后触发的方法
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        
    }
    //用户点击书库按钮后触发的方法
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar){
        
    }
    //用户点击取消按钮后触发的方法
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
        
    }
    //用户点击搜索结果按钮后触发的方法
    func searchBarResultsListButtonClicked(_ searchBar: UISearchBar){
        
    }
    //用户点击搜索栏附件视图上的按钮后触发的方法
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int){
        
    }



}

