//
//  ViewController.swift
//  Calculator
//
//  Created by vip on 16/10/31.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController,BoardButtonInputDelegate {
    let board = Board()
    let screen = Screen()
    let calculator = CalculatorEngine()
    var isNew = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        installUI()
      
    }
    
    func installUI() {
        
        self.view.addSubview(board)
        board.delegate = self
        board.snp.makeConstraints { (maker) in
            maker.left.equalTo(0)
            maker.right.equalTo(0)
            maker.bottom.equalTo(0)
            maker.height.equalTo(board.superview!.snp.height).multipliedBy(2/3.0)
        }
        
        self.view.addSubview(screen)
        screen.snp.makeConstraints { (maker) in
            maker.left.equalTo(0)
            maker.right.equalTo(0)
            maker.top.equalTo(0)
            maker.bottom.equalTo(board.snp.top)
        }
    }

    func boardButtonClick(content: String) {
        if content == "AC" || content == "Delete" || content == "=" {
            //进行功能逻辑
            switch content {
            case "AC":
                screen.clearContent()
                screen.refreshHistory()
            case "Delete":
                screen.deleteInput()
            case "=":
                let result = calculator.calculatEquation(equation: screen.inputString)
                screen.refreshHistory()
                screen.clearContent()
                screen.inputContent(content: String(result))
                isNew = true
            default:
                screen.refreshHistory()
            }
            
        }else{
            if isNew {
                screen.clearContent()
                isNew = false
            }
            screen.inputContent(content: content)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

