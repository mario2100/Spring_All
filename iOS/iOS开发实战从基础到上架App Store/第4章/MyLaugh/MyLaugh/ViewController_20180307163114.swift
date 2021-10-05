//
//  ViewController.swift
//  MyLaugh
//
//  Created by vip on 17/1/12.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    let TEXTURL = "http://route.showapi.com/341-1?showapi_appid=58027&showapi_sign=74b9fcd59b844b98b6427da974f4e2e9&page=%d"
    var currentPage = 0
    var dataArray = Array<DataContentistModel>()
    var moreBtn:UIButton?
    override func viewDidLoad() {
        super.viewDidLoad()
        currentPage = 1
        self.title = "笑一笑"
        moreBtn = UIButton(type: .system)
        moreBtn?.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 30)
        moreBtn?.setTitle("加载更多~~", for: .normal)
        moreBtn?.addTarget(self, action: #selector(readMore), for: .touchUpInside)
        self.tableView.tableFooterView = moreBtn!
        self.getData(page:currentPage)
        self.creatRefresh()
    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        MyNetworking.requestGet(url: "http://route.showapi.com/341-1?showapi_appid=58027&showapi_sign=74b9fcd59b844b98b6427da974f4e2e9") { (success, data) in
//            let dic = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
//            print(dic)
//        }
//    }

    func getData(page:Int)  {
        MyNetworking.requestGet(url: String(format: TEXTURL, currentPage)) { (success, data) in
            if success{
                self.currentPage += 1
                let dic:Dictionary<String,Any>? = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? Dictionary<String, Any>
                if dic==nil {
                    //因为数据的问题不能解析 跳过此页
                    self.getData(page: self.currentPage)
                }else{
                    if dic!["showapi_res_body"] == nil{
                        self.currentPage-=1;
                        return;
                    }
                    let dataDic:Dictionary<String,Any> = dic!["showapi_res_body"] as! Dictionary<String, Any>
                    let model = RootDataModel()
                    model.setValuesForKeys(dataDic)
                    self.dataArray.append(contentsOf: model.contentModels)
                    self.tableView.reloadData()
                }
            }else{
                let alert = UIAlertController(title: "温馨提示", message: "网络或服务异常", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }

    func readMore() {
        self.getData(page: currentPage)
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(dataArray[indexPath.row].height)
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:TextTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "TextTableViewCell") as? TextTableViewCell
        if cell==nil {
            cell = TextTableViewCell(style: .default, reuseIdentifier: "TextTableViewCell")
        }
        let model = dataArray[indexPath.row]
        cell?.title = model.title
        cell?.content=model.text
        cell?.date = "更新时间\(model.ct.substring(to: model.ct.index(model.ct.startIndex, offsetBy: 10)))"
        if model.height==0 {
            model.height = (cell?.getHeight())!
        }else{
            cell?.setContentLabelHeight(height: model.height-56)
        }
        return cell!
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func creatRefresh() {
        self.refreshControl?.tintColor = UIColor.green
        self.refreshControl?.addTarget(self, action: #selector(change), for: .valueChanged)
    }
    func change(refreshControl:UIRefreshControl) {
        moreBtn?.isEnabled = false
        MyNetworking.requestGet(url: String(format: TEXTURL, 1)) { (success, data) in
            if success{
                let dic:Dictionary<String,Any>? = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? Dictionary<String, Any>
                if dic==nil {
                    //因为数据的问题不能解析 跳过此页
                    self.getData(page: self.currentPage)
                }else{
                    if dic!["showapi_res_body"] == nil{
                        self.moreBtn?.isEnabled = true
                        self.refreshControl?.endRefreshing()
                        return;
                    }
                    let dataDic:Dictionary<String,Any> = dic!["showapi_res_body"] as! Dictionary<String, Any>
                    let model = RootDataModel()
                    model.setValuesForKeys(dataDic)
                    self.dataArray.removeAll()
                    self.dataArray.append(contentsOf: model.contentModels)
                    self.tableView.reloadData()
                }
            }else{
                let alert = UIAlertController(title: "温馨提示", message: "网络或服务异常", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
            self.moreBtn?.isEnabled = true
            self.refreshControl?.endRefreshing()
        }
    }

}

