//
//  TipButton.swift
//  BlueGame
//
//  Created by vip on 17/3/14.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit

class TipButton: UIButton {
    //标记此瓦片是否已经落子了 0空 1己方落子 2敌方落子
    var hasChess:Int = 0
    //设置白子或黑子
    var isWhite:Bool?
    //瓦片编号
    var index:Int?
    //落子 参数决定是己方还是敌方
    func dropChess(isMine:Bool) {
        let view = UIView(frame: CGRect(x: self.frame.width/2-5, y: self.frame.height/2-5, width: 10, height: 10))
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 5
        var myColor:UIColor?
        var otherColor:UIColor?
        if  isWhite! {
            myColor = UIColor.white
            otherColor = UIColor.black
        }else{
            myColor = UIColor.black
            otherColor = UIColor.white
        }
        if isMine {
            view.backgroundColor = myColor!
            self.hasChess = 1
        }else{
            view.backgroundColor = otherColor!
            self.hasChess = 2
        }
        self.addSubview(view)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.creatView()
    }
    func creatView() {
        //创建横竖两条线
        let line1 = UIView(frame: CGRect(x: self.frame.width/2-0.25, y: 0, width: 0.5, height: self.frame.height))
        line1.backgroundColor = UIColor.gray
        self.addSubview(line1)
        let line2 = UIView(frame: CGRect(x: 0, y: self.frame.height/2-0.25, width: self.frame.width, height: 0.5))
        line2.backgroundColor = UIColor.gray
        self.addSubview(line2)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
