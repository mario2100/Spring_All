//
//  ViewController.swift
//  UIViewTransitionTest
//
//  Created by vip on 17/2/20.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var contentView:UIView?
    private var contentView2:UIView?
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        contentView?.backgroundColor = UIColor.red
        self.view.addSubview(contentView!)
        contentView2 = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        contentView2?.backgroundColor = UIColor.blue
    }

//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        UIView.transition(with: contentView!, duration: 3, options: [.transitionFlipFromLeft,.allowAnimatedContent], animations: { 
//            self.contentView?.backgroundColor = UIColor.blue
//        }, completion: nil)
//    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.transition(from: contentView!, to: contentView2!, duration: 3, options: [.transitionFlipFromLeft,.allowAnimatedContent], completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

