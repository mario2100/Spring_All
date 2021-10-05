//
//  ViewController.swift
//  WebKitTest
//
//  Created by vip on 16/9/11.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit
import WebKit
class ViewController: UIViewController,WKScriptMessageHandler,WKUIDelegate {

    //声明WKWebView属性
    var wkView:WKWebView?
    var progressView:UIProgressView?
    override func viewDidLoad() {
        super.viewDidLoad()
        //创建网页配置
        let configuration = WKWebViewConfiguration()
        //配置进程池
        let processPool = WKProcessPool()
        configuration.processPool = processPool
        
        //偏好配置
        let prefrence = WKPreferences()
        //设置网页界面的最小字号
        prefrence.minimumFontSize = 0
        //设置是否支持JavaScript脚本 默认为true
        prefrence.javaScriptEnabled = true
        //设置是否允许不经过用户交互由JacaScript代码自动打开窗口
        prefrence.javaScriptCanOpenWindowsAutomatically = true
        configuration.preferences = prefrence
    

        
        
        //进行原生与JavaScript交互配置
        let userContentController = WKUserContentController()
        //设置代理并且注册要被javaScript代码调用的原生方法名称
        userContentController.add(self, name: "nativeFunc")
        //向网页中注入一段javaScript代码
        let javaScriptString = "function userFunc(){window.webkit.messageHandlers.nativeFunc.postMessage({\"班级\":\"珲少学堂\"})};userFunc()"
        let userScript = WKUserScript(source: javaScriptString, injectionTime: .atDocumentStart, forMainFrameOnly: false)
        //进行注入
        userContentController.addUserScript(userScript)
        configuration.userContentController = userContentController
        
        
        
        //对网页视图进行实例化
        wkView = WKWebView(frame: self.view.frame, configuration: configuration)
        self.view.addSubview(wkView!)
        let url = URL(string: "http://www.baidu.com")
        let request = URLRequest( url: url!)
        wkView!.load(request)
        
        //创建进度条控件
        progressView = UIProgressView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 10))
        progressView?.progressTintColor = UIColor.green()
        progressView?.progress = 0
        self.view.addSubview(progressView!)
        //对WKWebView实例的estimatedProgress属性进行监听
        wkView?.addObserver(self, forKeyPath: "estimatedProgress", options:NSKeyValueObservingOptions.new, context: nil)
        
        wkView?.uiDelegate = self
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: AnyObject?, change: [NSKeyValueChangeKey : AnyObject]?, context: UnsafeMutablePointer<Void>?) {
        if keyPath == "estimatedProgress" {
            progressView?.progress = Float(wkView!.estimatedProgress)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(message.body,message.name)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: () -> Void) {
        print(message)
        completionHandler()
    }
}

