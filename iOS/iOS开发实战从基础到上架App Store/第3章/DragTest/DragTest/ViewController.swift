//
//  ViewController.swift
//  DragTest
//
//  Created by jaki on 2018/2/28.
//  Copyright © 2018年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIDragInteractionDelegate,UIDropInteractionDelegate {
    let dragView:UIView = {
        let view = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        view.backgroundColor = UIColor.orange
        return view
    }()
    let label = UILabel(frame: CGRect(x: 100, y: 350, width: 100, height: 30))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(dragView)
        //拖拽行为对象
        let drag = UIDragInteraction(delegate: self)
        dragView.addInteraction(drag)
        drag.isEnabled = true
        
        label.backgroundColor = UIColor.green
        self.view.addSubview(label)
        label.isUserInteractionEnabled = true
        let drop = UIDropInteraction(delegate: self)
        label.addInteraction(drop)
    }
    //提供数据
    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        let provider = NSItemProvider(object: "hello" as NSItemProviderWriting)
        let item = UIDragItem(itemProvider: provider)
        return [item]
    }
    //是否可以成为接收者
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return true
    }
    //以何种行为接收数据 这里设置为复制
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .copy)
    }
    //接收数据
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        session.loadObjects(ofClass: String.self) { (obj) in
            self.label.text = obj.first!
        }
    }
}

