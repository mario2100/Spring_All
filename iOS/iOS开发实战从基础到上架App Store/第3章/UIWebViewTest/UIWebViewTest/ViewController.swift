//
//  ViewController.swift
//  UIWebViewTest
//
//  Created by vip on 16/12/27.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIWebViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        let webView = UIWebView(frame: self.view.bounds)
        let url = URL(string: "http://www.baidu.com")
        let request = URLRequest(url: url!)
//        webView.loadRequest(request)
        let htmlStr = "<html><head><meta charset=\"UTF-8\"><title> 主标题 | 副标题</title></head><body><p>hello world</p></body></html>"
//        webView.loadHTMLString(htmlStr, baseURL: nil)
        let imageUrl = URL(fileURLWithPath: Bundle.main.path(forResource: "image", ofType: "png", inDirectory: nil)!)
        let data = try! Data(contentsOf: imageUrl)
        webView.load(data, mimeType: "image/gif", textEncodingName: "", baseURL: imageUrl)
        self.view.addSubview(webView)
        webView.dataDetectorTypes = [.address,.link]
        webView.delegate = self
    }

    //加载失败调用的方法
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        
    }
    //将要加载请求是调用的方法
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
    //加载数据结束调用的方法
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
    }
    //开始加载数据时调用的方法
    func webViewDidStartLoad(_ webView: UIWebView) {
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

