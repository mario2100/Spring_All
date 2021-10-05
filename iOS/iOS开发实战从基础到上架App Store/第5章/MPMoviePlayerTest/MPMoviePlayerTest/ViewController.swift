//
//  ViewController.swift
//  MPMoviePlayerTest
//
//  Created by vip on 17/2/6.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit
import MediaPlayer
class ViewController: UIViewController {

    var movieController:MPMoviePlayerController?
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = Bundle.main.path(forResource: "iphone", ofType: "mp4")
        let url = URL(fileURLWithPath: path!)
        movieController = MPMoviePlayerController(contentURL: url)
        movieController?.view.frame = CGRect(x: 0, y: 0, width: 320, height: 300)
        self.view.addSubview(movieController!.view)
        NotificationCenter.default.addObserver(self, selector: #selector(getThumbImage), name: Notification.Name.MPMoviePlayerThumbnailImageRequestDidFinish, object: nil)
        movieController?.prepareToPlay()
        movieController!.requestThumbnailImages(atTimes: [NSNumber(value: 100)], timeOption: .nearestKeyFrame)
        //进行视频播放
        movieController?.play()
    }
    func getThumbImage(noti:Notification)  {
        let image = noti.userInfo![MPMoviePlayerThumbnailImageKey] as? UIImage
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 350, width: 320, height: 200)
        self.view.addSubview(imageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

