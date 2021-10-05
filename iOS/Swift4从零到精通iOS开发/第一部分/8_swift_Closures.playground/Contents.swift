//: Playground - noun: a place where people can play

import UIKit

//标准函数 这个函数的功能是计算某个整数的平方
func myFunc(param:Int)->Int{
    return param*param
}
//闭包的实现方式
let myClosures = {(param:Int) in
    return param*param
}
//对函数进行调用 将返回9
//swift3.0
myFunc(param: 3)
//对闭包进行调用 将返回9
myClosures(3)
//swift3.0
func mySort(array:inout Array<Any>,sortClosure:(Int,Int)->Bool) -> Array<Any> {
    //进行冒泡排序算法
    for indexI in array.indices {
        //最后一个元素直接返回
        if indexI == array.count-1 {
            break
        }
        //冒泡排序
        for indexJ in 0...((array.count-1)-indexI-1){
            //调用传递进来的闭包算法
            if sortClosure(indexJ,indexJ+1) {
                
            }else{
                //进行元素交换
                swap(&array[indexJ], &array[indexJ+1])
            }
        }
    }
    return array
}

var  array:Array<Any> = [1,4,3,5,7,5,4,2,7]
//swift3.0
mySort(array: &array,sortClosure: {(index:Int, nextIndex:Int) -> Bool in
    return (array[index] as! Int) > (array[nextIndex] as! Int)
})
print(array)
//编写一个学生类
class Student {
    //学生成绩
    let achievement:Int
    //学生姓名
    let name:String
    //构造方法
    init(name:String,achievement:Int){
        self.achievement = achievement
        self.name=name
    }
}


//创建4个学生
let stu1 = Student(name: "小王", achievement: 89)
let stu2 = Student(name: "小李", achievement: 69)
let stu3 = Student(name: "小张", achievement: 81)
let stu4 = Student(name: "小孙", achievement: 93)
//将学生放入数组
var stuArr:Array<Any> = [stu1,stu2,stu3,stu4]
//进行排序
//swift3.0
mySort(array: &stuArr) {
    (stuArr[$0] as! Student).achievement > (stuArr[$1] as! Student).achievement
}
//原结构
//swift3.0
mySort(array: &stuArr, sortClosure: {
    (stuArr[$0] as! Student).achievement > (stuArr[$1] as! Student).achievement
})
//后置闭包结构
//swift3.0
mySort(array: &stuArr){
    (stuArr[$0] as! Student).achievement > (stuArr[$1] as! Student).achievement
}
//只有一个闭包参数的函数 将此闭包声明为非逃逸的 此闭包不可作为返回值返回 也不可赋值给外部变量
//swift2.2
//func myFunc(@noescape closure:(Int,Int)->Bool){
//    
//}
//swift3.0
func myFunc( closure:@noescape(Int,Int)->Bool){
    
}
//进行闭包的后置 可以省略参数列表
myFunc {
    $0>$1
}


//将闭包参数声明为自动闭包 逃逸闭包
//swift2.2
//func myFunc2(@autoclosure(escaping) closure:()->Bool)  {
//    
//}
func myFunc2( closure:@autoclosure @escaping ()->Bool)  {
    
}
//调用函数时，直接传入一个表达式即可，编译器会自动生成闭包参数
//swift3.0
myFunc2(closure: 1+2+3>10)



//1.使用闭包的风格模拟Dictionary数据的遍历。
//创建一个字典示例
let dic:Dictionary = [1:"1",2:"2",3:"3",4:"4",5:"5"]
//创建一个函数 通过闭包来传递遍历结果
func MyEnumDic(dic:Dictionary<Int,String>,closure:(_ key:Int,_ value:String)->Bool){
    //遍历字典
    for item in dic {
        //执行闭包代码
        if closure(item.0,item.1) {
            return
        }
    }
}
MyEnumDic(dic: dic) { (key, value) -> Bool in
    if key == 3 {
        print(value)
        return true
    }
    print(value)
    return false
}



