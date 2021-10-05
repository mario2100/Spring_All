//
//  ViewController.swift
//  Flappy Bird
//
//  Created by vip on 17/2/25.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController,GamestartViewDelegate,GameOverViewDelegate{
    var bird:Bird?
    //背景
    var bg1:UIImageView?
    var bg2:UIImageView?
    //定时器
    var timer:Timer?
    //第一对管道
    var woodUp1:UIImageView?
    var woodDown1:UIImageView?
    //第二对管道
    var woodUp2:UIImageView?
    var woodDown2:UIImageView?
    //地面
    var floor1:UIImageView?
    var floor2:UIImageView?
    //游戏开始与结束视图
    var startView:GameStartView?
    var overView:GameOverView?
    //分数统计
    var sourceLabel:UILabel?
    var source:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        //初始化分数
        source = 0
        //创建背景
        self.creatBG()
        //创建管道
        self.creatWood()
        //创建地板
        self.creatFloor()
        //初始化像素鸟
        bird = Bird(frame: CGRect.zero)
        //设置位置
        bird?.center = CGPoint(x: 100, y: 300)
        self.view.addSubview(bird!)
        //开始飞行动画
        bird?.startFlaying()
        //初始化游戏开始与结束视图
        startView = GameStartView(frame: self.view.frame)
        overView = GameOverView(frame: self.view.frame)
        self.view.addSubview(startView!)
        self.view.addSubview(overView!)
        startView?.delegate = self
        overView?.delegate = self
        //初始化定时器
        timer = Timer.scheduledTimer(timeInterval: 1/60.0, target: self, selector: #selector(updateUI), userInfo: nil, repeats: true)
        //将定时器暂停
        timer?.fireDate = Date.distantFuture
        //创建计分板
        self.creatSourceLabel()
    }
    func creatBG()  {
        bg1 = UIImageView(frame: self.view.bounds)
        bg1?.image = UIImage(named: "bg")
        bg2 = UIImageView(frame: CGRect(x: self.view.frame.width, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        bg2?.image = UIImage(named: "bg")
        self.view.addSubview(bg1!)
        self.view.addSubview(bg2!)
    }
    func creatWood()  {
        //一屏最多同时出现2组管道
        woodUp1 = UIImageView(image: UIImage(named: "04"))
        woodDown1 = UIImageView(image: UIImage(named: "05"))
        woodUp2 = UIImageView(image: UIImage(named: "04"))
        woodDown2 = UIImageView(image: UIImage(named: "05"))
        //取一个随机数作为初始高度
        let sH = self.view.frame.size.height;
        //下面柱子的高度最少为150
        //柱子间缝隙为100
        //上面柱子的高度最少为150
        let parm = sH-150-100-150
        var height = Int(arc4random())%Int(parm)+150
        woodUp1?.frame = CGRect(x: 600, y: height-325, width: 54, height: 325)
        woodDown1?.frame = CGRect(x: 600, y: height+100, width: 54, height: 325)
        height = Int(arc4random())%Int(parm)
        woodUp2?.frame = CGRect(x: 780, y: height-325, width: 54, height: 325)
        woodDown2?.frame = CGRect(x: 780, y: height+100, width: 54, height: 325)
        self.view.addSubview(woodUp1!)
        self.view.addSubview(woodUp2!)
        self.view.addSubview(woodDown1!)
        self.view.addSubview(woodDown2!)
    }
    func creatFloor()  {
        floor1 = UIImageView(frame: CGRect(x: 0, y: self.view.frame.height-112, width: 336, height: 112))
        floor2 = UIImageView(frame: CGRect(x: self.view.frame.width, y: self.view.frame.height-112, width: 336, height: 112))
        floor1?.image = UIImage(named: "03")
        floor2?.image = UIImage(named: "03")
        self.view.addSubview(floor1!)
        self.view.addSubview(floor2!)
    }
    func creatSourceLabel(){
        sourceLabel = UILabel(frame: CGRect(x: self.view.frame.width/2-25, y: 100, width: 50, height: 50))
        sourceLabel?.backgroundColor = UIColor.clear
        sourceLabel?.textAlignment = .center
        sourceLabel?.font = UIFont.systemFont(ofSize: 23)
        sourceLabel?.textColor = UIColor.red
        sourceLabel?.isHidden = true
        self.view.addSubview(sourceLabel!)
    }
    func updateUI()  {
        let x = bg1!.frame.origin.x
        if x <= -self.view.frame.width  {
            bg1!.frame = self.view.bounds
            bg2!.frame = CGRect(x: self.view.frame.width, y:0 , width: self.view.frame.width, height: self.view.frame.height)
            floor1!.frame = CGRect(x: 0, y: self.view.frame.height-112, width: 336, height: 112)
            floor2!.frame = CGRect(x: self.view.frame.width, y: self.view.frame.height-112, width: 336, height: 112)
        }
        bg1?.frame = CGRect(x: bg1!.frame.origin.x-1, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        bg2?.frame = CGRect(x: bg2!.frame.origin.x-1, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        floor1?.frame = CGRect(x: floor1!.frame.origin.x-1, y: self.view.frame.height-112, width: 336, height: 112)
        floor2?.frame = CGRect(x: floor2!.frame.origin.x-1, y: self.view.frame.height-112, width: 336, height: 112)
        woodUp1?.frame = CGRect(x: woodUp1!.frame.origin.x-1, y: woodUp1!.frame.origin.y, width: woodUp1!.frame.width, height: woodUp2!.frame.height)
        woodUp2?.frame = CGRect(x: woodUp2!.frame.origin.x-1, y: woodUp2!.frame.origin.y, width: woodUp2!.frame.width, height: woodUp2!.frame.height)
        woodDown1?.frame = CGRect(x: woodDown1!.frame.origin.x-1, y: woodDown1!.frame.origin.y, width: woodDown1!.frame.width, height: woodDown1!.frame.height)
        woodDown2?.frame = CGRect(x: woodDown2!.frame.origin.x-1, y: woodDown2!.frame.origin.y, width: woodDown2!.frame.width, height: woodDown2!.frame.height)
        if woodUp1!.frame.origin.x+woodUp1!.frame.width <= 0 {
            //将其往后放
            let sH = self.view.frame.height
            let parm = sH-150-100-150
            let height = Int(arc4random())%Int(parm)+150
            woodUp1?.frame = CGRect(x: woodUp2!.frame.origin.x+280, y: CGFloat(height)-woodUp2!.frame.height, width: woodUp1!.frame.width, height: woodUp1!.frame.height)
            woodDown1?.frame = CGRect(x: woodUp2!.frame.origin.x+280, y: CGFloat(height)+100, width: woodUp1!.frame.width, height: woodUp1!.frame.height)
        }
        if woodUp2!.frame.origin.x+woodUp2!.frame.width <= 0 {
            //将其往后放
            let sH = self.view.frame.height
            let parm = sH-150-100-150
            let height = Int(arc4random())%Int(parm)+150
            woodUp2?.frame = CGRect(x: woodUp1!.frame.origin.x+280, y: CGFloat(height)-woodUp1!.frame.height, width: woodUp2!.frame.width, height: woodUp2!.frame.height)
            woodDown2?.frame = CGRect(x: woodUp1!.frame.origin.x+280, y: CGFloat(height)+100, width: woodUp2!.frame.width, height: woodUp2!.frame.height)
        }
        //进行分数更新
        if bird!.frame.origin.x == woodUp1!.frame.origin.x+woodUp1!.frame.width {
            source! += 1
            sourceLabel!.text = "\(source!)"
        }
        //进行死亡判定 
        self.ifDead()
    }
    func ifDead() {
        //落地
        if bird!.frame.origin.y+bird!.frame.height > floor1!.frame.origin.y {
            //死亡
            bird?.stopFlaying()
            bird?.stopLand()
            timer?.fireDate = Date.distantFuture
            overView?.setSource(source: source!)
            overView?.show()
            sourceLabel?.isHidden = true
            source = 0
        }
        //碰上管道
        if bird!.frame.intersects(woodUp1!.frame) || bird!.frame.intersects(woodUp2!.frame) || bird!.frame.intersects(woodDown1!.frame) || bird!.frame.intersects(woodDown2!.frame){
            //死亡
            bird?.stopFlaying()
            bird?.stopLand()
            timer?.fireDate = Date.distantFuture
            overView?.setSource(source: source!)
            overView?.show()
            sourceLabel?.isHidden = true
            source = 0
        }
    }
    
    func gameOverViewUnshow() {
        startView?.show()
        //进行初始化设置
        bird?.center = CGPoint(x: 100, y: 300)
        bird?.startFlaying()
        let sH = self.view.frame.height
        //下面柱子的高度最少为150
        //柱子间缝隙为100
        //上面柱子的高度最少为150
        let parm = sH-150-100-150
        var height = Int(arc4random())%Int(parm)+150
        woodUp1?.frame = CGRect(x: 600, y: height-325, width: 54, height: 325)
        woodDown1?.frame = CGRect(x: 600, y: height+100, width: 54, height: 325)
        height = Int(arc4random())%Int(parm)
        woodUp2?.frame = CGRect(x: 780, y: height-325, width: 54, height: 325)
        woodDown2?.frame = CGRect(x: 780, y: height+100, width: 54, height: 325)
        
    }
    func gameStartViewTouchStart() {
        startView?.unShow()
        timer?.fireDate = Date.distantPast
        sourceLabel?.isHidden = false
        bird?.startLand()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        bird?.upFlay()
    }
}

