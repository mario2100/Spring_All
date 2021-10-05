//
//  ViewController.swift
//  UISearchBarTest
//
//  Created by vip on 16/12/20.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        let searchBar = UISearchBar(frame: CGRect(x: 20, y: 100, width: 280, height: 30))
        searchBar.tintColor = UIColor.red
        searchBar.placeholder = "请输入要搜索的内容"
        searchBar.showsScopeBar = true
        searchBar.showsCancelButton = true
        searchBar.showsBookmarkButton = true
//        searchBar.showsSearchResultsButton = true
        searchBar.scopeButtonTitles = ["one","two","three"]
        searchBar.delegate = self
        self.view.addSubview(searchBar)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //单机切换扩展栏上按钮时触发的方法
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
    }
    //搜索框中字符将要改变时触发的方法
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return  true
    }
    //搜索框中字符已经改变后触发的方法
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    //点击图书按钮触发的方法
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        
    }
    //点击取消按钮触发的方法
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
    //点击搜索结果按钮触发的方法
    func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {
        
    }
    //点击键盘上的搜索键触发的方法
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
    //搜索框将要开始编辑时触发的方法
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    //搜索框将要结束编辑时触发的方法
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    //搜索框已经开始编辑时触发的方法
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
    }
    //搜索框已经结束编辑时触发的方法
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }


}

