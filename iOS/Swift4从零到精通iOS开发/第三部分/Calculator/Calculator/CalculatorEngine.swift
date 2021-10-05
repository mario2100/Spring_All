//
//  CalculatorEngine.swift
//  Calculator
//
//  Created by vip on 16/11/3.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class CalculatorEngine: NSObject {
    let funcArray:CharacterSet = ["+","-","*","/","^","%"]
    func calculatEquation(equation:String)->Double  {
        //以运算符进行分割获取到所有数字
        let elementArray = equation.components(separatedBy: funcArray)
        var tip = 0
        var result:Double = Double(elementArray[0])!
        for char in equation.characters {
            switch char {
            case "+":
                tip += 1
                if elementArray.count>tip {
                    result+=Double(elementArray[tip])!
                }
            case "-":
               tip += 1
               if elementArray.count>tip {
                result-=Double(elementArray[tip])!
                }
            case "*":
               tip += 1
               if elementArray.count>tip {
                result*=Double(elementArray[tip])!
                }
            case "/":
                tip += 1
                if elementArray.count>tip {
                    result/=Double(elementArray[tip])!
                }
            case "%":
                tip += 1
                if elementArray.count>tip {
                    result = Double(Int(result)%Int(elementArray[tip])!)
                }
            case "^":
                tip += 1
                if elementArray.count>tip {
                    let tmp = result
                    for _ in 1..<Int(elementArray[tip])! {
                        result*=tmp
                    }
                    
                }
            default:
                break
            }
        }
        return result
    }
}
