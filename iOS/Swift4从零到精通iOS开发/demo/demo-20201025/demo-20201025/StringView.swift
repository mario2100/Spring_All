//
//  StringView.swift
//  demo-20201025
//
//  Created by 姜骏赫 on 2021/10/25.
//

import Foundation

import UIKit

class StringView: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var str = "Hello Swift"
        var str1:String = "Hello Swift baby"
        str = ""
        print(str)
        print(str1)
        print(MemoryLayout<String>.size)
        let name = "China"
        //swift 5 deprecated 废弃了这个变量
        for character in name.characters{
            print(character)
        }
        var d = "Hello\(123344)"
        print(d)
        if !name.isEmpty{
            print(name+"不为空")
        }
        var startIndex = str1.startIndex
        var  endIndex = str1.endIndex
        var subString = str1[startIndex...str1.index(startIndex,offsetBy: 4)]
        print(subString)
        
    }
    
}
