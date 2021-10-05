//
//  ViewController.swift
//  UIWebViewGIF
//
//  Created by vip on 17/2/24.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let web = UIWebView(frame: CGRect(x: 20, y: 100, width: 280, height: 200))
        //读取素材数据
        let gifData = try! Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "gifImage", ofType: "gif")!))
        web.load(gifData, mimeType: "image/gif", textEncodingName: "", baseURL: URL(fileURLWithPath: Bundle.main.path(forResource: "gifImage", ofType: "gif")!))
        self.view.addSubview(web)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

