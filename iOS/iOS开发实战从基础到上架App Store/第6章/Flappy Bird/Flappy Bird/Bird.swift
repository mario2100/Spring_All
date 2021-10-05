//
//  Bird.swift
//  Flappy Bird
//
//  Created by vip on 17/2/25.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit

class Bird: UIImageView {
    let G=4
    //定时器
    private var timer:Timer?
    //是否应该降落
    private var couldLand = false
    //下落速度
    private var speed:Float = 0
    
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 40, height: 31))
        self.image = UIImage(named:"bird1")
        //创建飞行动画
        var array = Array<UIImage>()
        for i in 0..<3{
            let image = UIImage(named: "bird\(i+1)")
            array.append(image!)
        }
        self.animationImages = array
        self.animationDuration = 1
        self.animationRepeatCount = 0
        //初始化定时器
        timer = Timer.scheduledTimer(timeInterval: 1/60.0, target: self, selector: #selector(updateBird), userInfo: nil, repeats: true)
    }
    
    func updateBird() {
        if couldLand {
            //小鸟掉落
            self.center = CGPoint(x: self.center.x, y: self.center.y+CGFloat(speed))
            speed += Float(G)/60
            //超出边界做处理
            if self.center.y<=0 {
                self.center = CGPoint(x: self.center.x, y: 0)
            }else if(self.center.y+self.frame.height/2 >= self.superview!.frame.height){
                self.center = CGPoint(x: self.center.x, y: self.superview!.frame.height-self.frame.height/2)
            }
        }else{
            speed = 0
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //开始与结束飞行动作
    func startFlaying() {
        if self.isAnimating {
            return
        }
        
        self.startAnimating()
    }
    func stopFlaying()  {
        if self.isAnimating {
            self.stopAnimating()
        }
    }
    //开始与停止重力降落
    func startLand()  {
        couldLand = true
    }
    func stopLand()  {
        couldLand = false
    }
    //向上飞
    func upFlay() {
        //给小鸟一个向上的初速度
        speed = -2.5
    }
    
    
}
