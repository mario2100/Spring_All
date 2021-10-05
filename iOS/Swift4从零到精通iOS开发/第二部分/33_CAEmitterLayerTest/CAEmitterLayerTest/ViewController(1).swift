//
//  ViewController.swift
//  CAEmitterLayerTest
//
//  Created by vip on 16/10/10.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        //配置粒子发射引擎
        let fireEmitter = CAEmitterLayer()
        //设置发射引擎的位置和尺寸
        //将发射引擎放在屏幕底部中间
        fireEmitter.emitterPosition = CGPoint(x: self.view.bounds.size.width/2, y: self.view.bounds.size.height-20)
        fireEmitter.emitterSize = CGSize(width: self.view.bounds.size.width-100, height: 20)
        //粒子的渲染模式为混合渲染
        fireEmitter.renderMode = kCAEmitterLayerAdditive
        
        //配置粒子单元
        //配置两个粒子单元 一个用来渲染火焰 一个用来渲染烟雾
        
        //配置火焰单元
        let fireCell = CAEmitterCell()
        //设置每秒产生1500个粒子
        fireCell.birthRate = 1500
        //每个粒子的存活时间为3秒
        fireCell.lifetime = 3.0
        //设置粒子的存活时间随机范围为1.5秒
        fireCell.lifetimeRange = 1.5
        //设置粒子渲染颜色
        fireCell.color = UIColor(red: 0.8, green: 0.4, blue: 0.2, alpha: 0.1).cgColor
        //设置粒子的内容
        fireCell.contents = UIImage(named: "emtter")?.cgImage
        //设置粒子运动速度为120
        fireCell.velocity = 120
        //设置粒子运动速度随机范围为60
        fireCell.velocityRange = 60
        //设置粒子在x-y平面的发射角度
        fireCell.emissionLongitude = CGFloat(M_PI+M_PI_2)
        //设置粒子发射角度的随机范围
        fireCell.emissionRange = CGFloat(M_PI_2)
        //设置粒子的缩放速率
        fireCell.scaleSpeed = 0.5;
        //设置粒子的旋转
        fireCell.spin = 0.2;
        
        //配置烟雾粒子
        let smokeCell = CAEmitterCell()
        smokeCell.birthRate = 1000
        smokeCell.lifetime = 4.0
        smokeCell.lifetimeRange = 1.5
        smokeCell.color = UIColor(red: 1, green: 1, blue: 1, alpha: 0.05).cgColor
        smokeCell.contents = UIImage(named: "emtter")?.cgImage
        smokeCell.velocity = 200
        smokeCell.velocity = 100
        smokeCell.emissionLongitude = CGFloat(M_PI+M_PI_2)
        smokeCell.emissionRange = CGFloat(M_PI_2)
        
        //配置粒子发射引擎的粒子单元
        fireEmitter.emitterCells = [fireCell,smokeCell]
        self.view.layer.addSublayer(fireEmitter)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

