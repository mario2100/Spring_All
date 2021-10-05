//
//  ViewControllerTwo.swift
//  UIViewControllerTest2
//
//  Created by vip on 16/8/29.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

protocol ViewControllerTwoProtocol {
    func sentedData(data:String)
}



class ViewControllerTwo: UIViewController {

    
    var data:String
    var delegate:ViewControllerTwoProtocol?
    var closure:((String)->Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        //添加返回按钮
        self.view.backgroundColor = UIColor.red()
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 30))
        button.setTitle("返回", for: UIControlState())
        button.addTarget(self, action: #selector(ret), for: UIControlEvents.touchUpInside)
        self.view.addSubview(button)
        //添加一个文本标签
        let label = UILabel(frame: CGRect(x: 20, y: 200, width: 280, height: 30))
        label.text = data
        self.view.addSubview(label)
    }
    func ret() {
//        delegate?.sentedData(data: "第2个界面传递的值")
        self.closure!("第2个界面通过闭包传递的值")
        self.dismiss(animated: true, completion: nil)
    }
    
    
    init(data:String) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.data=""
        super.init(coder: aDecoder)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
