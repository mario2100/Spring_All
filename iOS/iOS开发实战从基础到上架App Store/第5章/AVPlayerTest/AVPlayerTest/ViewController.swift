//
//  ViewController.swift
//  AVPlayerTest
//
//  Created by vip on 17/2/7.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
class ViewController: UIViewController,AVPlayerViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func playMovie(_ sender: UIButton) {
        let path = Bundle.main.path(forResource: "iphone", ofType: "mp4")
        let url = URL(fileURLWithPath: path!)
        let play = AVPlayerViewController()
        play.delegate = self
        play.player = AVPlayer(url: url)
        self.present(play, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func playerViewControllerWillStartPictureInPicture(_ playerViewController: AVPlayerViewController) {
        
    }
    func playerViewControllerDidStartPictureInPicture(_ playerViewController: AVPlayerViewController) {
        
    }
    func playerViewController(_ playerViewController: AVPlayerViewController, failedToStartPictureInPictureWithError error: Error) {
        
    }
    func playerViewControllerWillStopPictureInPicture(_ playerViewController: AVPlayerViewController) {
        
    }
    func playerViewControllerDidStopPictureInPicture(_ playerViewController: AVPlayerViewController) {
        
    }
    func playerViewController(_ playerViewController: AVPlayerViewController, restoreUserInterfaceForPictureInPictureStopWithCompletionHandler completionHandler: @escaping (Bool) -> Void) {
        
    }
    func playerViewControllerShouldAutomaticallyDismissAtPictureInPictureStart(_ playerViewController: AVPlayerViewController) -> Bool {
        return true
    }
}

