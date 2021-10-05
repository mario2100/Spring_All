//
//  ViewController.swift
//  AVAudioPlayerTest
//
//  Created by vip on 17/1/19.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer
class ViewController: UIViewController {

    var player:AVAudioPlayer?
    func updateProgress()  {
        let current = self.player?.currentTime;
        let duration = self.player?.duration;
        let m1 = Int(current!)/60
        let s1 = Int(current!)%60
        let m2 = Int(duration!)/60
        let s2 = Int(duration!)%60
        self.timelabel.text = String(format: "%02d:%02d/%02d:%02d", m1,s1,m2,s2)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(fileURLWithPath: Bundle.main.path(forResource: "红模仿", ofType: "mp3")!)
        player = try? AVAudioPlayer(contentsOf: url)
        player?.enableRate = true
        timer = Timer.scheduledTimer(timeInterval: 1/60.0, target: self, selector: #selector(updateProgress), userInfo: nil, repeats: true)
        if player!.prepareToPlay() {
            player?.play()
        }
        var dict = Dictionary<String,Any>()
        dict[MPMediaItemPropertyTitle] = "牛仔很忙"
        dict[MPMediaItemPropertyArtist] = "周杰伦"
        dict[MPMediaItemPropertyAlbumTitle] = "我很忙"
        let newImage = UIImage(named: "我很忙")
        let item = MPMediaItemArtwork(image: newImage!)
        dict[MPMediaItemPropertyArtwork] = item
        dict[MPMediaItemPropertyPlaybackDuration] = NSNumber(value: 300)
        dict[MPMediaItemPropertyBookmarkTime] = NSNumber(value: 150)
        MPNowPlayingInfoCenter.default().nowPlayingInfo = dict
        
        
    }
    @IBAction func volume(_ sender: UISlider) {
        let value = sender.value
        player?.volume = value
    }
    @IBAction func soundTrack(_ sender: UISlider) {
        let value = (sender.value-0.5)*2
        player?.pan = value
    }
    @IBAction func speed(_ sender: UISlider) {
        let value = sender.value+0.5
        player?.rate = value
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func play(_ sender: UIButton) {
        if player!.isPlaying {
            return
        }
        player?.play()
    }
    @IBAction func pause(_ sender: UIButton) {
        if player!.isPlaying {
            player?.pause()
        }
    }
    @IBAction func stop(_ sender: UIButton) {
        if player!.isPlaying {
            player?.stop()
        }
    }

    @IBOutlet weak var timelabel: UILabel!
    var timer:Timer?

}

