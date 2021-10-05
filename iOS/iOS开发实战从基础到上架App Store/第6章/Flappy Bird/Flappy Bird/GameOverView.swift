//
//  GameOverView.swift
//  Flappy Bird
//
//  Created by vip on 17/2/28.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit


protocol GameOverViewDelegate {
    func gameOverViewUnshow()
}

class GameOverView: UIView {
    var delegate:GameOverViewDelegate?
    private var label:UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        let bg = UIImageView(frame: CGRect(x: self.frame.width/2-124, y: 100, width: 248, height: 56))
        bg.image = UIImage(named: "gameover2")
        self.addSubview(bg)
        label = UILabel(frame: CGRect(x: self.frame.width/2-25, y: 200, width: 50, height: 50))
        label?.backgroundColor = UIColor.clear
        label?.textAlignment = .center
        label?.font = UIFont.systemFont(ofSize: 23)
        label?.textColor = UIColor.red
        self.addSubview(label!)
        self.alpha = 0
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.unShow()
        self.delegate?.gameOverViewUnshow()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func show()  {
        UIView.animate(withDuration: 0.3) { 
            self.alpha = 1
        }
    }
    func unShow() {
        UIView.animate(withDuration: 0.3) { 
            self.alpha = 0
        }
    }
    func setSource(source:Int)  {
        label!.text = "\(source)"
    }
    
}
