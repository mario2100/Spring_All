//
//  AppDelegate.swift
//  MyPlayer
//
//  Created by vip on 17/2/8.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit
import AVFoundation
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var play:MyMusicPlayer?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let sesstion = AVAudioSession.sharedInstance()
        try? sesstion.setActive(true)
        try? sesstion.setCategory(AVAudioSessionCategoryPlayback)
        UIApplication.shared.beginReceivingRemoteControlEvents()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        NotificationCenter.default.post(name: NSNotification.Name("goBack"), object: nil)
    }
    func applicationDidBecomeActive(_ application: UIApplication) {
        NotificationCenter.default.post(name: NSNotification.Name("goForward"), object: nil)
    }
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    override func remoteControlReceived(with event: UIEvent?) {
        if event!.type == .remoteControl {
            switch event!.subtype {
            case .remoteControlPlay:
                self.play?.play()
            case .remoteControlNextTrack:
                self.play?.nextMusic()
            case .remoteControlPreviousTrack:
                self.play?.lastMusic()
            case .remoteControlPause:
                self.play?.stop()
            case .remoteControlTogglePlayPause:
                self.play?.playOrStop()
            default:
                break
            }
        }
    }
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }



    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

