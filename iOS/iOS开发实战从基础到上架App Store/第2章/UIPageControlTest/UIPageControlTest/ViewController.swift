//
//  ViewController.swift
//  UIPageControlTest
//
//  Created by vip on 16/12/14.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        let page = UIPageControl(frame: CGRect(x: 20, y: 100, width: 280, height: 30))
        page.currentPageIndicatorTintColor = UIColor.red
        page.addTarget(self, action: #selector(changeNum), for: .valueChanged)
        page.numberOfPages = 8
        self.view.addSubview(page)
    }
    func changeNum(page:UIPageControl)  {
        print(page.currentPage)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

