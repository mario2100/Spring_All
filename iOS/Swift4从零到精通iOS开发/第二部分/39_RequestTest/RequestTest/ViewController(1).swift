//
//  ViewController.swift
//  RequestTest
//
//  Created by vip on 16/10/18.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //请求url 格式化字符串
    let urlString = "http://api.tianapi.com/wxnew/?key=%@&num=1"
    //apikey
    let apikey = "ef7f04344615b7ff44a8b3aa78aa27f3"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //创建请求配置
        let config = URLSessionConfiguration.default
        //创建请求URL
        let url = URL(string: String(format: urlString, apikey))
        //创建请求实例
        let request = URLRequest(url: url!)

//        //设置请求方法为POST
//        request.httpMethod = "POST"
//        //设置请求体参数
//        request.httpBody = "paramString".data(using: .utf8)
        //创建请求Session
        let session = URLSession(configuration: config)
        //创建请求任务
        let task = session.dataTask(with: request) { (data, response, error) in
            let dictionary = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
            print(dictionary ?? "未解析到数据")
        }
        //激活请求任务
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

