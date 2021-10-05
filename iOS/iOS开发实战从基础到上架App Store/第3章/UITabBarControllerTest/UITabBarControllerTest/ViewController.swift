//
//  ViewController.swift
//  UITabBarControllerTest
//
//  Created by vip on 16/12/23.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let tabBar = UITabBarController()
        tabBar.tabBar.barTintColor = UIColor.green
        tabBar.tabBar.tintColor = UIColor.purple
        var array = Array<UIViewController>()
        for index in 0..<5 {
            let con = UIViewController()
//          con.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: index)
//            con.tabBarItem = UITabBarItem(title: "title", image: UIImage(named: "image"), tag: index)
//            con.tabBarItem = UITabBarItem(title: "title", image: UIImage(named: "image"), selectedImage: UIImage(named: "image"))
            con.view.backgroundColor = UIColor(red: CGFloat(arc4random()%255)/255.0, green: CGFloat(arc4random()%255)/255.0, blue: CGFloat(arc4random()%255)/255.0, alpha: 1)
            con.tabBarItem.title = "\(index)视图"
            con.tabBarItem.image = UIImage(named: "tab_bar_icon_home")
            con.tabBarItem.selectedImage = UIImage(named: "tab_bar_icon_home_selected")
            array.append(con)
            
        }
        tabBar.viewControllers = array
        self.present(tabBar, animated: true, completion: nil)
    }

    
}

