//
//  LRCEngine.swift
//  MyPlayer
//
//  Created by vip on 17/2/8.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit

class LRCEngine: NSObject {
    init(fileName:String) {
        super.init()
        lrcArray = Array<LRCItem>()
        creatData(file:fileName)
    }
    func creatData(file:String) {
        //读取文件
        let lrcPath = Bundle.main.path(forResource: file, ofType: "lrc")
        let dataStr = try! String(contentsOf: URL(fileURLWithPath: lrcPath!), encoding: .utf8)
        //去掉\r
        var tmpArray =  dataStr.components(separatedBy: "\r")
        var tmpStr = String()
        for index in 0..<tmpArray.count {
            tmpStr=tmpStr.appending(tmpArray[index])
        }
        //按照换行进行分割
        let lrcArray = tmpStr.components(separatedBy: "\n")
        //解析并将空数据去掉
        for str in lrcArray {
            if str.characters.count==0 {
                continue
            }
            //判断是歌词数据还是文件信息数据
            let c = str[str.index(after: str.startIndex)]
            if c>="0"&&c<="9" {
                //是歌词数据
                getLrc(data:str)
            }else{
                //是文件信息数据
                getInfo(data:str)
            }
        }
        self.lrcArray?.sort(by: { (item1, item2) -> Bool in
            return item1.time<item2.time
        })
    }
    var author:String?
    var albume:String?
    var title:String?
    func getCurrentLRC(handle:(Array<LRCItem>,Int)->Void,time:Float)  {
        if self.lrcArray?.count==0 {
            handle([],0)
        }
        //找到时间大于time的歌词位置
        var index = -2
        for i in 0..<self.lrcArray!.count {
            let lrcTime = self.lrcArray![i].time
            if lrcTime>time {
                index = i-1
                break
            }

        }
        if index == -1 {
            index=0
        }else if index == -2{
            //没有更大的时间了
            index = self.lrcArray!.count-1
        }
         handle(self.lrcArray!,index)
    }
    private var lrcArray:Array<LRCItem>?
    func getLrc(data:String) {
        //按照]进行分割
        let arr = data.components(separatedBy: "]")
        //解析时间
        for index in 0..<arr.count-1{
            //去掉[号
            let timeStr = arr[index].substring(from: arr[index].index(after: arr[index].startIndex))
            //把时间转换成秒为单位
            let timeArr = timeStr.components(separatedBy: ":")
            let min = Float(timeArr[0])
            let sec = Float(timeArr[1])
            //创建模型
            let item = LRCItem()
            item.time = min!*60+sec!
            item.lrc = arr.last!
            self.lrcArray?.append(item)
        }
    }
    func getInfo(data:String) {
        //按照]进行分割
        let arr = data.components(separatedBy: "]")
        if arr[0] == "[ti" {
            self.title = arr[1].substring(to: arr[1].index(before: arr[1].endIndex))
        }else if arr[0]=="[ar" {
            self.author = arr[1].substring(to: arr[1].index(before: arr[1].endIndex))
        }else if arr[0]=="[al" {
            self.albume = arr[1].substring(to: arr[1].index(before: arr[1].endIndex))
        }
    }
}
