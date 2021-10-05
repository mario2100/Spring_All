//
//  ModelController.swift
//  UIPageViewControllerTest
//
//  Created by vip on 16/9/24.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

/*
 A controller object that manages a simple model -- a collection of month names.
 
 The controller serves as the data source for the page view controller; it therefore implements pageViewController:viewControllerBeforeViewController: and pageViewController:viewControllerAfterViewController:.
 It also implements a custom method, viewControllerAtIndex: which is useful in the implementation of the data source methods, and in the initial configuration of the application.
 
 There is no need to actually create view controllers for each page in advance -- indeed doing so incurs unnecessary overhead. Given the data model, these methods create, configure, and return a new view controller on demand.
 */


class ModelController: NSObject, UIPageViewControllerDataSource {

    //存放月份数据
    var pageData: [String] = []
    //构造方法
    override init() {
        super.init()
        let dateFormatter = DateFormatter()
        //获取到月份数据
        pageData = dateFormatter.monthSymbols
    }
    //获取月份对应的视图控制器
    func viewControllerAtIndex(_ index: Int, storyboard: UIStoryboard) -> DataViewController? {
        //安全校验
        if (self.pageData.count == 0) || (index >= self.pageData.count) {
            return nil
        }
        //创建视图控制器
        let dataViewController = storyboard.instantiateViewController(withIdentifier: "DataViewController") as! DataViewController
        //设置视图控制器的标题
        dataViewController.dataObject = self.pageData[index]
        return dataViewController
    }
    //获取某个视图控制器在数组中的位置
    func indexOfViewController(_ viewController: DataViewController) -> Int {
        return pageData.index(of: viewController.dataObject) ?? NSNotFound
    }

    // MARK: - Page View Controller Data Source

    //这个协议方法会在用户向前翻页时调用 这里需要将要展示的视图控制器返回 如果返回nil 则不能够再向前翻页
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! DataViewController)
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index -= 1
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }
    //这个协议方法会在用户向后翻页时调用 这里需要将要展示的视图控制器返回 如果返回nil 则不能够在向后翻页
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! DataViewController)
        if index == NSNotFound {
            return nil
        }
        
        index += 1
        if index == self.pageData.count {
            return nil
        }
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }

    //设置页码数
    func presentationCount(for pageViewController: UIPageViewController) -> Int{
        return pageData.count
    }
    //设置出初始选中的页码点
    func presentationIndex(for pageViewController: UIPageViewController) -> Int{
        return 0 
    }
}

