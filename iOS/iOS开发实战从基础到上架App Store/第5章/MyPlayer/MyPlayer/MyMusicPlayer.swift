//
//  MyMusicPlayer.swift
//  MyPlayer
//
//  Created by vip on 17/2/10.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit
import AVFoundation

protocol MyMusicPlayerDelegate {
    func musicPlayEnd(willContinuePlaying:Bool)
}
class MyMusicPlayer: NSObject,AVAudioPlayerDelegate {
    //歌曲名数组
    var songArray = Array<String>()
    //对应歌曲的歌词数组
    var lrcsArray = Array<LRCEngine>()
    //是否循环播放
    var isRunLoop = true
    //是否随机播放
    var isRandom = false
    //音频播放器是否正在播放音频
    var isPlaying = false
    //代理
    var delegate:MyMusicPlayerDelegate?
    //获取当前播放的是第几个音频
    var currentIndex = 0
    //获取当前播放音频的时长
    var currentSongTime = 0
    //当前音频文件已经播放的时长
    var hadPlayTime = 0
    
    
    //进行继续播放与暂停播放的切换
    func playOrStop() {
        //先判断是否正在播放
        if self.isPlaying {
            self.stop()
        }else{
            self.play()
        }
    }
    //开始播放
    func play()  {
        //判断AVAudioPlayer对象是否存在
        if player != nil {
            player!.play()
            self.isPlaying = true
        }else{
            //从歌曲数组中读取第一个元素
            let path = Bundle.main.path(forResource: songArray[0], ofType: "mp3")
            let url = URL(fileURLWithPath: path!)
            player = try! AVAudioPlayer(contentsOf: url)
            player?.delegate = self
            player?.play()
            isPlaying = true
            currentIndex = 0
            currentSongTime = Int(player!.duration)
        }
    }
    //暂停播放
    func stop() {
        guard self.player != nil else {
            return
        }
        if player!.isPlaying{
            player?.stop()
            isPlaying=false
        }
    }
    //停止播放
    func end() {
        player?.stop()
        isPlaying = false
        player = nil
    }
    //播放指定的音频文件
    func play(atIndex:Int,playing:Bool) {
        player?.stop()
        isPlaying=false
        player=nil
        let path = Bundle.main.path(forResource: songArray[atIndex], ofType: "mp3")
        let url = URL(fileURLWithPath: path!)
        player = try! AVAudioPlayer(contentsOf: url)
        player?.delegate = self
        if playing {
            player?.play()
            isPlaying = true
        }
        currentIndex = atIndex
        currentSongTime = Int(player!.duration)
    }
    //下一曲
    func nextMusic() {
        guard self.player != nil else {
            return
        }
        let play = player!.isPlaying
        player?.stop()
        isPlaying = false
        player = nil
        //是否为最后一曲
        if currentIndex<songArray.count-1{
            currentIndex+=1
        }else{
            currentIndex = 0
        }
        //是否随机播放
        if self.isRandom {
            let max = songArray.count
            currentIndex = Int(arc4random())%max
        }
        let path = Bundle.main.path(forResource: songArray[currentIndex], ofType: "mp3")
        let url = URL(fileURLWithPath: path!)
        player = try! AVAudioPlayer(contentsOf: url)
        player?.delegate = self
        if play {
            player?.play()
            isPlaying = true
        }
    }
    //上一曲
    func lastMusic() {
        guard self.player != nil else {
            return
        }
        let play = player!.isPlaying
        player?.stop()
        isPlaying = false
        player = nil
        //是否为最后一曲
        if currentIndex>0{
            currentIndex-=1
        }else{
            currentIndex = songArray.count-1
        }
        //是否随机播放
        if self.isRandom {
            let max = songArray.count
            currentIndex = Int(arc4random())%max
        }
        let path = Bundle.main.path(forResource: songArray[currentIndex], ofType: "mp3")
        let url = URL(fileURLWithPath: path!)
        player = try! AVAudioPlayer(contentsOf: url)
        player?.delegate = self
        if play {
            player?.play()
            isPlaying = true
        }
    }
   

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.player = nil
        isPlaying = false
        if isRandom {
            let max = songArray.count
            currentIndex = Int(arc4random())%max
            
        }
        //是否为最后一曲
        if currentIndex<songArray.count-1{
            currentIndex+=1
        }else if isRunLoop {
            currentIndex = 0
        }else{
            self.delegate?.musicPlayEnd(willContinuePlaying: false)
            return
        }
        let path = Bundle.main.path(forResource: songArray[currentIndex], ofType: "mp3")
        let url = URL(fileURLWithPath: path!)
        self.player = try! AVAudioPlayer(contentsOf: url)
        self.player?.delegate = self
        self.player?.play()
        isPlaying = true
        self.delegate?.musicPlayEnd(willContinuePlaying: true)
        currentSongTime = Int(self.player!.duration)
    }
    
    private var player:AVAudioPlayer?
    private var timer:Timer?
    
    override init() {
        super.init()
        timer = Timer.scheduledTimer(timeInterval: 1/60.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .commonModes)
        let delegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        delegate.play = self
    }
    func update(){
        if let p = player {
            hadPlayTime = Int(p.currentTime)
        }
    }
    
}
