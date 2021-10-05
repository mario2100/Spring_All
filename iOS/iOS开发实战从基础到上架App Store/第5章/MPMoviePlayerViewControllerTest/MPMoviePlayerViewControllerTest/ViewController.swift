//
//  ViewController.swift
//  MPMoviePlayerViewControllerTest
//
//  Created by vip on 17/2/7.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit
import MediaPlayer
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func playMovie(_ sender: UIButton) {
        let path = Bundle.main.path(forResource: "iphone", ofType: "mp4")
        let url = URL(fileURLWithPath: path!)
        let controller = MPMoviePlayerViewController(contentURL: url)
        self.present(controller!, animated: true, completion: nil)
    }

}

