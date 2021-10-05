//
//  RootViewController.swift
//  UIPageViewControllerTest
//
//  Created by vip on 16/9/24.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, UIPageViewControllerDelegate {

    var pageViewController: UIPageViewController?


    override func viewDidLoad() {
        super.viewDidLoad()
        //对分页视图控制器进行构造 
        //第一个参数为分页视图控制器的风格
        /*
         可选的风格如下
         public enum UIPageViewControllerTransitionStyle : Int {
         case pageCurl  翻页风格
         case scroll    滚动风格
         }
         */
        //第二个参数为分页视图控制器的切换方向 支持水平和竖直两种方向
        self.pageViewController = UIPageViewController(transitionStyle: .pageCurl, navigationOrientation: .horizontal, options: nil)
        
        //设置代理为当前类实例本身
        self.pageViewController!.delegate = self
        //创建一个起始的视图控制器
        let startingViewController: DataViewController = self.modelController.viewControllerAtIndex(0, storyboard: self.storyboard!)!
        //将起始视图控制器添加到UIPageViewController的视图控制器组中
        let viewControllers = [startingViewController]
        self.pageViewController!.setViewControllers(viewControllers, direction: .forward, animated: false, completion: {done in })
        //设置数据源提供者为ModelController对象
        self.pageViewController!.dataSource = self.modelController
        //将分页视图控制器的View添加到当前视图上
        self.addChildViewController(self.pageViewController!)
        self.view.addSubview(self.pageViewController!.view)
        //设置分页视图控制器的视图尺寸
        var pageViewRect = self.view.bounds
        if UIDevice.current.userInterfaceIdiom == .pad {
            pageViewRect = pageViewRect.insetBy(dx: 40.0, dy: 40.0)
        }
        self.pageViewController!.view.frame = pageViewRect

        self.pageViewController!.didMove(toParentViewController: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //计算属性 其中实现了get方法块
    var modelController: ModelController {
        if _modelController == nil {
            _modelController = ModelController()
        }
        return _modelController!
    }

    var _modelController: ModelController? = nil

    // MARK: - UIPageViewController delegate methods

    //屏幕方向改变时调用
    func pageViewController(_ pageViewController: UIPageViewController, spineLocationFor orientation: UIInterfaceOrientation) -> UIPageViewControllerSpineLocation {
        //如果当前是被是iPhone或者屏幕方向为垂直方向 返回书籍为左侧或上侧
        if (orientation == .portrait) || (orientation == .portraitUpsideDown) || (UIDevice.current.userInterfaceIdiom == .phone) {
            let currentViewController = self.pageViewController!.viewControllers![0]
            let viewControllers = [currentViewController]
            self.pageViewController!.setViewControllers(viewControllers, direction: .forward, animated: true, completion: {done in })

            self.pageViewController!.isDoubleSided = false
            return .min
        }
        //如果不是iPhone且设备的方向为水平方向
        let currentViewController = self.pageViewController!.viewControllers![0] as! DataViewController
        var viewControllers: [UIViewController]
        //获取当前所在的页号
        let indexOfCurrentViewController = self.modelController.indexOfViewController(currentViewController)
        //如果为偶数
        if (indexOfCurrentViewController == 0) || (indexOfCurrentViewController % 2 == 0) {
            let nextViewController = self.modelController.pageViewController(self.pageViewController!, viewControllerAfter: currentViewController)
            //添加下一个视图控制器
            viewControllers = [currentViewController, nextViewController!]
        //如果是基数
        } else {
            //添加上一个视图控制器
            let previousViewController = self.modelController.pageViewController(self.pageViewController!, viewControllerBefore: currentViewController)
            viewControllers = [previousViewController!, currentViewController]
        }
        self.pageViewController!.setViewControllers(viewControllers, direction: .forward, animated: true, completion: {done in })
        //返回书脊在中间
        return .mid
    }

    

}

