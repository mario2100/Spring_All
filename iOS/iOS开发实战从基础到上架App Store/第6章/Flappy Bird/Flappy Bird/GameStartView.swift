//
//  GameStartView.swift
//  Flappy Bird
//
//  Created by vip on 17/2/28.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit


protocol GamestartViewDelegate {
    func gameStartViewTouchStart()
}

class GameStartView: UIView {
    var delegate:GamestartViewDelegate?
    func show() {
        UIView.animate(withDuration: 0.3) { 
            self.alpha = 1
        }
    }
    func unShow() {
        UIView.animate(withDuration: 0.3) { 
            self.alpha = 0
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        let bg = UIImageView(frame: CGRect(x: self.frame.width/2-128, y: 100, width: 256, height: 73))
        bg.image = UIImage(named: "main")
        self.addSubview(bg)
        //开始按钮
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: self.frame.width/2-67, y: 350, width: 135, height: 75)
        btn.setBackgroundImage(UIImage(named: "start"), for: .normal)
        btn.addTarget(self, action: #selector(touch), for: .touchUpInside)
        self.addSubview(btn)
    }
    
    func touch() {
        self.unShow()
        self.delegate?.gameStartViewTouchStart()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
