//
//  ViewController.swift
//  MyFire
//
//  Created by vip on 17/2/23.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var fireEmitter:CAEmitterLayer?//粒子发射器
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        //设置发射器
        fireEmitter = CAEmitterLayer()
        fireEmitter?.emitterPosition = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height-20)
        fireEmitter?.emitterSize = CGSize(width: self.view.frame.width-100, height: 20)
        fireEmitter?.renderMode = kCAEmitterLayerAdditive
        //设置发射单元
        let fire = CAEmitterCell()
        fire.birthRate = 1600
        fire.lifetime = 4.0
        fire.lifetimeRange = 1.5
        fire.color = UIColor(red: 0.8, green: 0.4, blue: 0.2, alpha: 0.1).cgColor
        fire.contents = #imageLiteral(resourceName: "Particles_fire").cgImage
        fire.name = "fire"
        fire.velocity = 160
        fire.velocityRange = 80
        fire.emissionLongitude = CGFloat(M_PI+M_PI_2)
        fire.emissionRange = CGFloat(M_PI_2)
        fire.scaleSpeed = 0.3
        fire.spin = 0.2
        //烟雾
        let smoke = CAEmitterCell()
        smoke.birthRate = 800
        smoke.lifetime = 6.0
        smoke.lifetimeRange = 1.5
        smoke.color = UIColor(red: 1, green: 1, blue: 1, alpha: 0.05).cgColor
        smoke.contents = #imageLiteral(resourceName: "Particles_fire").cgImage
        smoke.name = "smoke"
        smoke.velocity = 250
        smoke.velocityRange = 100
        smoke.emissionLongitude = CGFloat(M_PI_2+M_PI)
        smoke.emissionRange = CGFloat(M_PI_2)
        fireEmitter?.emitterCells = [fire,smoke]
        self.view.layer.addSublayer(fireEmitter!)
        
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

