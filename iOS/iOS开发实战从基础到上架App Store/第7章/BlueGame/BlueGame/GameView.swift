//
//  GameView.swift
//  BlueGame
//
//  Created by vip on 17/3/14.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit
protocol GameViewDelegate {
    func gameViewClick(index:String)
}
class GameView: UIView,UIAlertViewDelegate {
    var tipArray:Array<TipButton>?
    var delegate:GameViewDelegate?
    //进行下子
    func setTipIndex(index:Int)  {
        for btn in tipArray! {
            if btn.index == index {
                btn.dropChess(isMine: false)
                self.check()
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        tipArray = Array<TipButton>()
        self.creatView()
    }
    //创建表格视图 横16 竖20
    func creatView()  {
        self.layer.borderColor = UIColor(red: 222/255.0, green: 222/255.0, blue: 222/255.0, alpha: 1).cgColor
        self.layer.borderWidth = 0.5
        let width = self.frame.width/12
        let height = self.frame.height/20
        //排列布局
        for i in 0..<240 {
            let btn = TipButton(frame: CGRect(x: width*CGFloat(i%12), y: height*CGFloat(i/12), width: width, height: height))
            btn.addTarget(self, action: #selector(click), for: .touchUpInside)
            btn.isWhite = false
            btn.index = i
            self.addSubview(btn)
            tipArray?.append(btn)
        }
    }
    func click(btn:TipButton) {
        if btn.hasChess == 0 {
            //下子
            btn.dropChess(isMine: true)
            //进行胜负判定
            self.check()
            self.delegate?.gameViewClick(index: "\(btn.index!)")
        }
    }
    func check()  {
        //判断己方是否胜利
        if self.checkMine() {
            let alert = UIAlertView(title: "您胜利啦", message: "", delegate: self, cancelButtonTitle: "好的")
            alert.show()
        }
        if self.checkOther() {
            let alert = UIAlertView(title: "您失败啦", message: "", delegate: self, cancelButtonTitle: "好的")
            alert.show()
        }
    }
    func checkOther()->Bool {
        //遍历所有棋子
        for i in 0..<tipArray!.count{
            let tip = tipArray![i]
            //获取是否是己方棋子
            if tip.hasChess==2 {
                //进行五子判定逻辑
                //横向
                if self.check1Has(mineOrOther:false,index:i) {
                    return true
                }
                //左上到右下的对角线
                if self.check2Has(mineOrOther:false,index:i) {
                    return true
                }
                //纵向
                if self.check3Has(mineOrOther:false,index:i) {
                    return true
                }
                //右上到左下的对角线
                if self.check4Has(mineOrOther:false,index:i) {
                    return true
                }
            }
        }
        return false
    }
    func checkMine()->Bool {
        //遍历所有棋子
        for i in 0..<tipArray!.count{
            let tip = tipArray![i]
            //获取是否是己方棋子
            if tip.hasChess==1 {
                //进行五子判定逻辑
                //横向
                if self.check1Has(mineOrOther:false,index:i) {
                    return true
                }
                //左上到右下的对角线
                if self.check2Has(mineOrOther:false,index:i) {
                    return true
                }
                //纵向
                if self.check3Has(mineOrOther:false,index:i) {
                    return true
                }
                //右上到左下的对角线
                if self.check4Has(mineOrOther:false,index:i) {
                    return true
                }
            }
        }
        return false
    }
    func check1Has(mineOrOther:Bool,index:Int) -> Bool {
        var mine = 0
        if mineOrOther {
            mine = 1
        }else{
            mine = 2
        }
        var count = 1
        //左侧右侧同时进行可以增加效率
        //左侧
        count = count+self.algorithmic1(index:index,param:mine,num:4)
        //右侧
        count = count+self.algorithmic2(index:index,param:mine,num:4)
        if count>=5 {
            return true
        }else{
            return false
        }
    }
    func check2Has(mineOrOther:Bool,index:Int) -> Bool {
        var mine = 0
        if mineOrOther {
            mine = 1
        }else{
            mine = 2
        }
        var count = 1
        //左上右下同时进行可以增加效率
        count = count+self.algorithmic3(index:index,param:mine,num:4)
        count = count+self.algorithmic4(index:index,param:mine,num:4)
        if count>=5 {
            return true
        }else{
            return false
        }
    }

    func check3Has(mineOrOther:Bool,index:Int) -> Bool {
        var mine = 0
        if mineOrOther {
            mine = 1
        }else{
            mine = 2
        }
        var count = 1
        //向上向下同时进行可以增加效率
        count = count+self.algorithmic5(index:index,param:mine,num:4)
        count = count+self.algorithmic6(index:index,param:mine,num:4)
        if count>=5 {
            return true
        }else{
            return false
        }
    }

    func check4Has(mineOrOther:Bool,index:Int) -> Bool {
        var mine = 0
        if mineOrOther {
            mine = 1
        }else{
            mine = 2
        }
        var count = 1
        count = count+self.algorithmic7(index:index,param:mine,num:4)
        count = count+self.algorithmic8(index:index,param:mine,num:4)
        if count>=5 {
            return true
        }else{
            return false
        }
    }
    
    func algorithmic1(index:Int,param:Int,num:Int) -> Int {
        if num>0 {
            let tem = 4-(num-1)
            //左侧有子
            if index-tem>=0 {
                //左侧无换行
                if ((index-tem)%12) != 11 {
                    if tipArray![index-tem].hasChess == param {
                        return self.algorithmic1(index: index, param: param, num: num-1)
                    }else{
                        return 4-num
                    }
                }else{
                    return 4-num
                }
            }else{
                return 4-num
            }
        }else{
            return 4-num
        }
    }
    func algorithmic2(index:Int,param:Int,num:Int) -> Int {
        if num>0 {
            let tem = 4-(num-1)
            //右侧有子
            if index+tem<240 {
                //右侧无换行
                if ((index+tem)%12) != 0 {
                    if tipArray![index+tem].hasChess == param {
                        return self.algorithmic2(index: index, param: param, num: num-1)
                    }else{
                        return 4-num
                    }
                }else{
                    return 4-num
                }
            }else{
                return 4-num
            }
        }else{
            return 4-num
        }
    }
    func algorithmic3(index:Int,param:Int,num:Int) -> Int {
        if num>0 {
            let tem = 4-(num-1)
            //左上有子
            if index-(tem*12)-tem >= 0 {
                //左侧无换行
                if ((index-(tem*12)-tem)%12) != 11 {
                    if tipArray![index-(tem*12)-tem].hasChess == param {
                        return self.algorithmic3(index: index, param: param, num: num-1)
                    }else{
                        return 4-num
                    }
                }else{
                    return 4-num
                }
            }else{
                return 4-num
            }
        }else{
            return 4-num
        }
    }
    func algorithmic4(index:Int,param:Int,num:Int) -> Int {
        if num>0 {
            let tem = 4-(num-1)
            //右下有子
            if index+(tem*12)+tem < 240 {
                //右侧无换行
                if ((index+(tem*12)+tem)%12) != 0 {
                    if tipArray![index+(tem*12)+tem].hasChess == param {
                        return self.algorithmic4(index: index, param: param, num: num-1)
                    }else{
                        return 4-num
                    }
                }else{
                    return 4-num
                }
            }else{
                return 4-num
            }
        }else{
            return 4-num
        }
    }
    func algorithmic5(index:Int,param:Int,num:Int) -> Int {
        if num>0 {
            let tem = 4-(num-1)
            //上有子
            if index-(tem*12) >= 0 {
                if tipArray![index-(tem*12)].hasChess == param {
                    return self.algorithmic5(index: index, param: param, num: num-1)
                }else{
                    return 4-num
                }
            }else{
                return 4-num
            }
        }else{
            return 4-num
        }
    }
    func algorithmic6(index:Int,param:Int,num:Int) -> Int {
        if num>0 {
            let tem = 4-(num-1)
            //下有子
            if index+(tem*12) < 240 {
                if tipArray![index+(tem*12)].hasChess == param {
                    return self.algorithmic6(index: index, param: param, num: num-1)
                }else{
                    return 4-num
                }
            }else{
                return 4-num
            }
        }else{
            return 4-num
        }
    }
    func algorithmic7(index:Int,param:Int,num:Int) -> Int {
        if num>0 {
            let tem = 4-(num-1)
            //右上有子
            if index-(tem*12)+tem >= 0 {
                //右侧无换行
                if ((index-(tem*12)+tem)%12) != 0 {
                    if tipArray![index-(tem*12)+tem].hasChess == param {
                        return self.algorithmic7(index: index, param: param, num: num-1)
                    }else{
                        return 4-num
                    }
                }else{
                    return 4-num
                }
            }else{
                return 4-num
            }
        }else{
            return 4-num
        }
    }
    func algorithmic8(index:Int,param:Int,num:Int) -> Int {
        if num>0 {
            let tem = 4-(num-1)
            //左下有子
            if index+(tem*12)-tem < 240 {
                //左侧无换行
                if ((index+(tem*12)-tem)%12) != 11 {
                    if tipArray![index+(tem*12)-tem].hasChess == param {
                        return self.algorithmic8(index: index, param: param, num: num-1)
                    }else{
                        return 4-num
                    }
                }else{
                    return 4-num
                }
            }else{
                return 4-num
            }
        }else{
            return 4-num
        }
    }
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        BlueToothTool.sharedManager().disConnect()
        (self.superview!.next! as! UIViewController).dismiss(animated: true, completion: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
