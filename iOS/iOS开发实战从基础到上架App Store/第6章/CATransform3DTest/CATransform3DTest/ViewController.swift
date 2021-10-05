//
//  ViewController.swift
//  CATransform3DTest
//
//  Created by vip on 17/2/23.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let image1 = UIImageView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        image1.image = #imageLiteral(resourceName: "image")
        let image2 = UIImageView(frame: CGRect(x: 100, y: 300, width: 100, height: 100))
        image2.image = #imageLiteral(resourceName: "image")
//        var trans = CATransform3DTranslate(image2.layer.transform, 100, 100, 0)
//        let tran = CATransform3DScale(trans, 0.5, 2, 0)
//        let tran2 = CATransform3DRotate(tran, CGFloat(M_PI_4), 0, 0, 1)
//        trans.m34 = -1/600.0
//        image2.layer.transform = trans
        let tran = CATransform3DRotate(image1.layer.transform, CGFloat(M_PI_4), 0, 0, 1)
        image1.layer.transform = tran
        
//        image2.layer.transform = CATransform3DRotate(trans, CGFloat(M_PI_4), 0, 1, 0)
        image2.layer.transform = CATransform3DInvert(tran)
        
        self.view.addSubview(image1)
        self.view.addSubview(image2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

