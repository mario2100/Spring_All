//
//  GameViewController.swift
//  BlueGame
//
//  Created by vip on 17/3/16.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit

class GameViewController: UIViewController,BlueToothToolDelegate,GameViewDelegate {
    private var bgView:UIView?
    private var tipLable:UILabel?
    private var _view:GameView?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.brown
        //创建游戏视图
        _view = GameView(frame: CGRect(x: 20, y: 40, width: self.view.frame.width-40, height: (self.view.frame.width-40)/12*20))
        _view?.delegate = self
        self.view.addSubview(_view!)
        //创建背景视图
        bgView = UIView(frame: self.view.frame)
        bgView?.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.1)
        let btn = UIButton(type: .system)
        btn.frame = CGRect(x: self.view.frame.width/2-50, y: 150, width: 100, height: 30)
        let btn2 = UIButton(type: .system)
        btn2.frame = CGRect(x: self.view.frame.width/2-50, y: 250, width: 100, height: 30)
        btn.setTitle("创建游戏", for: .normal)
        btn2.setTitle("扫描附近游戏", for: .normal)
        btn.backgroundColor = UIColor.orange
        btn2.backgroundColor = UIColor.orange
        btn.addTarget(self, action: #selector(creatGame), for: .touchUpInside)
        btn2.addTarget(self, action: #selector(searchGame), for: .touchUpInside)
        bgView?.addSubview(btn)
        bgView?.addSubview(btn2)
        self.view.addSubview(bgView!)
        //设置蓝牙通讯类代理
        BlueToothTool.sharedManager().delegate = self
        //创建提示标签
        tipLable = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40))
        self.view.addSubview(tipLable!)
        tipLable?.textAlignment = .center
    }
    func creatGame()  {
        BlueToothTool.sharedManager().setUpGame(name: "") { (first) in
            self.bgView?.removeFromSuperview()
            if first {
                self.tipLable?.text = "请您下子"
            }else{
                self.tipLable?.text = "请等待对方下子"
                self.view.isUserInteractionEnabled = false
                self.gameViewClick(index: "-1")
            }
        }
    }
    func searchGame()  {
        BlueToothTool.sharedManager().searchGame()
    }
    func getData(data: String) {
        if bgView?.subviews != nil {
            bgView?.removeFromSuperview()
        }
        if  Int(data) == -1 {
            tipLable?.text = "请您下子"
            self.view.isUserInteractionEnabled = true
            return
        }
        tipLable?.text = "请您下子"
        _view?.setTipIndex(index: Int(data)!)
        self.view.isUserInteractionEnabled = true
    }
    func gameViewClick(index: String) {
        tipLable?.text = "请等待对方下子"
        BlueToothTool.sharedManager().writeData(data: index)
        self.view.isUserInteractionEnabled = false
    }
}
