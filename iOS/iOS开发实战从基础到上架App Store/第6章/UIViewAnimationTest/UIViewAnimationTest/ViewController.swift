//
//  ViewController.swift
//  UIViewAnimationTest
//
//  Created by vip on 17/2/16.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var colorView:UIView?
    var timer:Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        colorView?.backgroundColor = UIColor.red
        self.view.addSubview(colorView!)

        timer = Timer(timeInterval: 1, target: self, selector: #selector(tim), userInfo: nil, repeats: true)
        timer?.fire()
    }
    
    func tim()  {
        print("11");
    }

//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
////        UIView.animate(withDuration: 3, animations: { 
////            self.colorView?.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
////        }) { (finished) in
////            print("动画完成")
////        }
////        UIView.animate(withDuration: 3, delay: 1, options: .curveEaseOut, animations: { 
////            self.colorView?.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
////        }) { (finish) in
////            print("动画完成")
////        }
////        UIView.animate(withDuration: 3, delay: 1, usingSpringWithDamping: 1, initialSpringVelocity: 20, options: .curveEaseIn, animations: { 
////            self.colorView?.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
////            self.colorView?.backgroundColor = UIColor.blue
////        }, completion: nil)
////        UIView.animate(withDuration: 3, animations: { 
////            self.colorView?.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
////        }) { (finish) in
////            UIView.animate(withDuration: 2, animations: { 
////                self.colorView?.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
////            }, completion: { (finish) in
////                UIView.animate(withDuration: 1, animations: { 
////                    self.colorView?.backgroundColor = UIColor.blue
////                })
////            })
////        }
//        UIView.animate(withDuration: 3) { 
//            self.colorView?.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_4))
//        }
//    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //第1部分 开始动画标志
        UIView.beginAnimations("test", context: nil)
        //第2部分 设置动画属性
        UIView.setAnimationDelegate(self)
        UIView.setAnimationWillStart(#selector(start))
        UIView.setAnimationDidStop(#selector(stop))
        UIView.setAnimationDuration(3)
        UIView.setAnimationDelay(1)
        UIView.setAnimationCurve(.easeInOut)
        UIView.setAnimationRepeatAutoreverses(true)
        UIView.setAnimationRepeatCount(3)
        //第3部分 设置要执行动画的属性
        colorView?.backgroundColor = UIColor.blue
        //第4部分 提交动画
        UIView.commitAnimations()
    }
    
    func start()  {
        
    }
    func stop() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

