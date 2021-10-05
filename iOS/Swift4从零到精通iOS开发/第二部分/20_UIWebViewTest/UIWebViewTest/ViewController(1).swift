//
//  ViewController.swift
//  UIWebViewTest
//
//  Created by vip on 16/9/11.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIWebViewDelegate {
    var webView:UIWebView?
    var buttonGoBack:UIButton!
    var buttonGoForward:UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        //创建WebView视图
        webView = UIWebView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height-30))
        //创建网页url
        let url = URL(string: "http://www.baidu.com")
        //创建请求
        let request = URLRequest(url: url!)
        //加载网页
        webView!.loadRequest(request)
        webView?.delegate = self
        self.view.addSubview(webView!)
        //创建工具条
        let toolView = UIView(frame: CGRect(x: 0, y: self.view.frame.size.height-30, width: self.view.frame.size.width, height: 30))
        toolView.backgroundColor = UIColor.purple
        self.view.addSubview(toolView)
        //添加两个功能按钮
        buttonGoBack = UIButton(frame: CGRect(x: 30, y: 0, width: 70, height: 30))
        buttonGoBack.setTitle("后退", for: UIControlState())
        buttonGoBack.setTitleColor(UIColor.lightGray, for: .disabled)
        buttonGoBack.addTarget(self, action: #selector(goBack), for: UIControlEvents.touchUpInside)
        
        buttonGoForward = UIButton(frame: CGRect(x: 130, y: 0, width: 70, height: 30))
        buttonGoForward.addTarget(self, action: #selector(goForward), for: UIControlEvents.touchUpInside)
        buttonGoForward.setTitle("前进", for: UIControlState())
        buttonGoForward.setTitleColor(UIColor.lightGray, for: .disabled)
        toolView.addSubview(buttonGoBack)
        toolView.addSubview(buttonGoForward)
    }

    func goBack()  {
        webView!.goBack()
    }
    
    func goForward()  {
        webView!.goForward()
    }
    
    //当视图将要开始加载URL请求时被调用 返回fasle则禁止此次加载
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        //网页开始加载
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        //网页加载完成
        buttonGoBack.isEnabled = webView.canGoBack
        buttonGoForward.isEnabled = webView.canGoForward
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        //网页加载失败
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

