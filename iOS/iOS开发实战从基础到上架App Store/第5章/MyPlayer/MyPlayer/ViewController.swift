//
//  ViewController.swift
//  MyPlayer
//
//  Created by vip on 17/2/8.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit
import MediaPlayer
class ViewController: UIViewController,MyMusicPlayerDelegate {
    private var player:MyMusicPlayer?
    //内容视图
    private var contentView:MusicContentView?
    //标题标签
    private var titleLabel:UILabel?
    //进度条
    private var progress:UIProgressView?
    //播放按钮
    private var playBtn:UIButton?
    //下一曲按钮
    private var nextBtn:UIButton?
    //上一曲按钮
    private var lastBtn:UIButton?
    //循环播放按钮
    private var circleBtn:UIButton?
    //随机播放按钮
    private var randomBtn:UIButton?
    //存放歌曲名
    private var dataArray:Array<String>?
    private var timer:Timer?
    private var isBack:Bool?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(phoneToBack), name: Notification.Name("goBack"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(phoneToForward), name: Notification.Name("goForward"), object: nil)
        isBack = false
        //创建数据
        creatData()
        //创建播放模块
        creatPlayer()
        //创建视图模块
        creatView()
        //进行刷新UI操作
        updateUI()
    }
    

    
    func creatData(){
        dataArray = ["匆匆那年","致青春","清风徐来","矜持","暗涌","天空","容易受伤的女人","清平调","但愿人长久","暧昧","执迷不悔","约定","我愿意","棋子","梦醒了","影子","人间","爱与痛的边缘","旋木","红豆","传奇","爱不可及"]
    }
    
    func creatPlayer(){
        player = MyMusicPlayer()
        player?.songArray = dataArray!
        var mulArr = Array<LRCEngine>()
        for index in 0..<dataArray!.count{
            //进行歌词模块的创建
            let engine = LRCEngine(fileName: dataArray![index])
            mulArr.append(engine)
        }
        player?.lrcsArray = mulArr
        player?.delegate = self
    }
    func creatView() {
        //创建背景
        let bg = UIImageView(frame: self.view.bounds)
        bg.image = UIImage(named: "BG.jpeg")
        //设置为可结束用户交互
        bg.isUserInteractionEnabled = true
        self.view.addSubview(bg)
        //创建歌曲标题Label
        titleLabel = UILabel(frame: CGRect(x: 0, y: 20, width: bg.frame.width, height: 40))
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel?.textAlignment = .center
        titleLabel?.text = dataArray![0]
        titleLabel?.backgroundColor = UIColor.clear
        titleLabel?.textColor = UIColor.white
        bg.addSubview(titleLabel!)
        //创建歌曲进度条
        progress = UIProgressView(progressViewStyle: .default)
        progress?.progressTintColor = UIColor.white
        progress?.frame = CGRect(x: 20, y: self.view.frame.height-70, width: self.view.frame.width-40, height: 5)
        bg.addSubview(progress!)
        //创建播放按钮
        playBtn = UIButton(type: .custom)
        playBtn?.setBackgroundImage(#imageLiteral(resourceName: "play"), for: .normal)
        playBtn?.setBackgroundImage(#imageLiteral(resourceName: "pause"), for: .selected)
        playBtn?.frame = CGRect(x: self.view.frame.width/2-20, y: self.view.frame.height-45, width: 40, height: 30)
        playBtn?.addTarget(self, action: #selector(playMusic), for: .touchDown)
        bg.addSubview(playBtn!)
        //创建下一曲按钮
        nextBtn = UIButton(type: .custom)
        nextBtn?.frame = CGRect(x: self.view.frame.width/2+40, y: self.view.frame.height-45, width: 40, height: 30)
        nextBtn?.setBackgroundImage(#imageLiteral(resourceName: "nextMusic"), for: .normal)
        nextBtn?.addTarget(self, action: #selector(nextSong), for: .touchUpInside)
        bg.addSubview(nextBtn!)
        //创建上一曲按钮
        lastBtn = UIButton(type: .custom)
        lastBtn?.frame = CGRect(x: self.view.frame.width/2-80, y: self.view.frame.height-45, width: 40, height: 30)
        lastBtn?.setBackgroundImage(#imageLiteral(resourceName: "aboveMusic"), for: .normal)
        lastBtn?.addTarget(self, action: #selector(lastSong), for: .touchUpInside)
        bg.addSubview(lastBtn!)
        //创建循环播放按钮
        circleBtn = UIButton(type: .custom)
        circleBtn?.frame = CGRect(x: self.view.frame.width/2-140, y: self.view.frame.height-45, width: 40, height: 30)
        circleBtn?.setBackgroundImage(#imageLiteral(resourceName: "circleClose"), for: .normal)
        circleBtn?.setBackgroundImage(#imageLiteral(resourceName: "circleOpen"), for: .selected)
        circleBtn?.addTarget(self, action: #selector(circle), for: .touchUpInside)
        bg.addSubview(circleBtn!)
        //创建随机播放按钮
        randomBtn = UIButton(type: .custom)
        randomBtn?.frame = CGRect(x: self.view.frame.width/2+100, y: self.view.frame.height-45, width: 40, height: 35)
        randomBtn?.setBackgroundImage(#imageLiteral(resourceName: "randomClose"), for: .normal)
        randomBtn?.setBackgroundImage(#imageLiteral(resourceName: "randomOpen"), for: .selected)
        randomBtn?.addTarget(self, action: #selector(random), for: .touchUpInside)
        bg.addSubview(randomBtn!)
        //创阿金歌曲列表与歌词显示控件视图
        contentView = MusicContentView(frame: CGRect(x: 0, y: 70, width:self.view.frame.width , height: self.view.frame.height-150))
        contentView?.titleDataArray = dataArray!
        contentView?.play = player!
        bg.addSubview(contentView!)
    }
    
    func playMusic()  {
        if player!.isPlaying {
            playBtn!.isSelected = false
            player!.stop()
        }else{
            playBtn?.isSelected = true
            player!.play()
        }
    }
    func nextSong() {
        player!.nextMusic()
    }
    func lastSong()  {
        player!.lastMusic()
    }
    func circle()  {
        if player!.isRunLoop {
            player?.isRunLoop = false
            circleBtn?.isSelected = false
        }else{
            player?.isRunLoop = true
            circleBtn?.isSelected = true
        }
    }
    func random()  {
        if player!.isRandom {
            player?.isRandom = false
            randomBtn?.isSelected = false
        }else{
            player!.isRandom = true
            randomBtn!.isSelected = true
        }
    }
    func updateUI() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .commonModes)
    }
    
    func update()  {
        titleLabel?.text = dataArray![player!.currentIndex]
        //更新进度条
        if player!.hadPlayTime != 0 {
            let progress = Float(player!.hadPlayTime)/Float(player!.currentSongTime)
            self.progress?.progress = progress
        }
        //更新歌词
        let engine = player!.lrcsArray[player!.currentIndex]
        engine.getCurrentLRC(handle: { (lrcArray, index) in
            contentView!.currentLRC(array: lrcArray, index: index)
        }, time: Float(player!.hadPlayTime))
        //更新锁屏界面
        if !isBack! {
            return
        }
        var dict = Dictionary<String,Any>()
        dict[MPMediaItemPropertyTitle] = dataArray![player!.currentIndex]
        dict[MPMediaItemPropertyArtist] = "王菲"
        dict[MPMediaItemPropertyAlbumTitle] = "致敬天后"
        dict[MPNowPlayingInfoPropertyElapsedPlaybackTime] = NSNumber(value: player!.hadPlayTime)
        dict[MPMediaItemPropertyPlaybackDuration] = NSNumber(value: player!.currentSongTime)
        MPNowPlayingInfoCenter.default().nowPlayingInfo = dict
        
    }
    func phoneToBack()  {
        isBack = true
    }
    func phoneToForward()  {
        isBack = false
    }
    func musicPlayEnd(willContinuePlaying: Bool) {
        if willContinuePlaying {
            playBtn!.isSelected = true
        }else{
            playBtn?.isSelected = false
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

