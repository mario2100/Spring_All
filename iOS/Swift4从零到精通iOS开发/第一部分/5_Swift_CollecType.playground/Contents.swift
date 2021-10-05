//: Playground - noun: a place where people can play

import UIKit
//Int型数组
var array1:[Int]
var array2:Array<Int>
//创建空数组
array1 = []
array2 = Array()
array1 = [1,2,3]
array2 = Array(arrayLiteral: 1,2,3)
//创建大量相同元素的数组
//创建有10个String类型元素的数组，并且每个元素都为字符串"Hello"
//swift2.2
//var array3 = [String](count: 10, repeatedValue: "Hello")
//swift3.0
var array3 = [String](repeating: "Hello", count: 10)
//创建有10个Int类型元素的数组，且每个元素都为1
//swift2.2
//var array4 = Array(count: 10, repeatedValue: 1)
//swift3.0
var array4 = Array(repeating: 1, count: 10)
//数组相加 array5 = [1,2,3,4,5,6]
var array5 = [1,2,3]+[4,5,6]

var array = [1,2,3,4,5,6,7,8,9]
//获取数组中元素的个数 9
array.count
//检查数组是否为空数组
if array.isEmpty {
    print("array为空数组")
}
//通过下标获取数组中的元素 1
var a = array[0]
//获取区间元素组成的新数组 [1,2,3,4]
var subArray = array[0...3]
//获取数组的第1个元素
var b = array.first
//获取数组的最后一个元素
var c = array.last
//修改数组中某个位置的元素
array[0] = 0
//修改数组中区间范围的元素
array[0...3] = [1,2,3,4]
//向数组中追加一个元素
array.append(10)
//向数组中追加一组元素
//swift2.2
//array.appendContentsOf([11,12,13])
//swift3.0
array.append(contentsOf: [11,12,13])
//向数组中的某个位置插入一个元素
//swift2.2
//array.insert(0, atIndex: 0)
//swift3.0
array.insert(0, at: 0)
//向数组中的某个位置插入一组元素
//swift2.2
//array.insertContentsOf([-2,-1], at: 0)
//swift3.0
array.insert(contentsOf: [-2,-1], at: 0)
//移除数组中某个位置的元素
//swift2.2
//array.removeAtIndex(1)
//swift3.0
array.remove(at: 1)
//移除数组中首个位置的元素
array.removeFirst()
//移除最后一个位置的元素
array.removeLast()
//移除前几位元素 参数为要移除元素的个数
array.removeFirst(2)
//移除后几位元素 参数为要移除元素的个数
array.removeLast(2)
//移除一个范围内的元素
//swift2.2
//array.removeRange(0...2)
//swift3.0
array.removeSubrange(0...2)
//修改一个范围内的元素
//swift2.2
//array.replaceRange(0...2, with: [0,1])
//swift3.0
array.replaceSubrange(0...2, with: [0,1])
//移除所有元素
array.removeAll()
//Int型数组
let arrayLet = [0,1,2,3,4]
//(Int,Int)型数组
let arrayLet2 = [(1,2),(2,3),(3,4)]
//判断数组中是否包含某个元素
if array.contains(1){
    print(true)
}

//直接遍历数组
for item in arrayLet {
    print(item)
}
//进行数组枚举遍历 将输出 (0,0) (1,1) (2,2) (3,3) (4,4)
//swift3.0 中将枚举属性enumerate 修改为enumerated()方法
for item in arrayLet.enumerated(){
    print(item)
}
//进行数组角标遍历
for index in arrayLet2.indices{
   print(arrayLet2[index], separator:"")
}

var arraySort = [1,3,5,6,7]
//获取数组中的最大值
//swift2.2
//arraySort.maxElement()
//swift3.0
arraySort.max()
//获取数组中的最小值
//swift2.2
//arraySort.minElement()
//swift3.0
arraySort.min()
//从大到小排序
//swift2.2
//arraySort = arraySort.sort(>)
//swift3.0
arraySort = arraySort.sorted(by: >)
//从小到大排序
//swift2.2
//arraySort = arraySort.sort(<)
//swift3.0
arraySort = arraySort.sorted(by: <)
//习题
/*
 1.将下列数组中的0去掉，返回新的数组。
 [1,13,45,5,0,0,16,6,0,25,4,17,6,7,0,15]
 */
var arrayOri1 = [1,13,45,5,0,0,16,6,0,25,4,17,6,7,0,15]
var arrayRes1 = Array<Int>()
for index in arrayOri1.indices {
    if arrayOri1[index] == 0 {
       continue
    }
    arrayRes1.append(arrayOri1[index])
}
print(arrayRes1)
/*
 2.定义一个包含10个元素的数组，对其进行赋值，使每个元素的值等于其下标，
 然后输出，最后将数组倒置后输出
 */
var arrayOri2 = Array<Int>()
for index in 0...9{
    arrayOri2.append(index)
}
print(arrayOri2)
arrayOri2.sort(by: { (a, b) -> Bool in
    return a>b
})
print(arrayOri2)

//创建set集合
var set1:Set<Int> = [1,2,3,4]
var set2 = Set(arrayLiteral: 1,2,3,4)
//获取集合首个元素 注意：顺序不定
set1[set1.startIndex]
//进行下标的移动
//获取某个下标后一个元素
//swlft2.2
//set1[set1.startIndex.successor()]
//swift3.0
set1[set1.index(after: set1.startIndex)]
//获取某个下标后几位的元素
//swift2.2
//set1[set1.startIndex.advancedBy(3)]
//swift3.0
set1[set1.index(set1.startIndex, offsetBy: 3)]
//获取元素个数
set1.count
//判断集合是否为空集合
if set1.isEmpty {
    print("集合为空")
}
//判断集合中是否包含某个元素
if set1.contains(1){
    print("集合包含")
}
//获取集合中的最大值
//swift2.2
//set1.maxElement()
//swift3.0
set1.max()
//获取集合中的最小值
//swift2.2
//set1.minElement()
//swift3.0
set1.min()

//向集合中插入一个元素
set1.insert(5)
//移除集合中的某个元素
set1.remove(1)
//移除集合中的第一个元素
set1.removeFirst()
//移除集合中某个位置的元素
//swift2.2
//set1.removeAtIndex(set1.indexOf(3)!)
//swift3.0
set1.remove(at: set1.index(of: 3)!)
//移除集合中所有的元素
set1.removeAll()

var set3:Set<Int> = [1,2,3,4]
var set4:Set<Int> = [1,2,5,6]
//返回交集 {1，2}
//swift2.2
//var setInter = set3.intersect(set4)
//swift3.0
var setInter = set3.intersection(set4)
//返回交集的补集{3，4，5，6}
//swift2.2
//var setEx = set3.exclusiveOr(set4)
//swift3.0
var setEx = set3.symmetricDifference(set4)
//返回并集{1，2，3，4，5，6}
var setUni = set3.union(set4)
//返回第二个集合的补集{3，4}
var setSub = set3.subtract(set4)

var set5:Set = [1,2]
var set6:Set = [2,3]
var set7:Set = [1,2,3]
var set8:Set = [1,2,3]
//判断是否是某个集合的子集 set5是set7的子集 返回ture
//swift2.2
//set5.isSubsetOf(set7)
//swift3.0
set5.isSubset(of: set7)
//判断是否是某个集合的超集 set7是set5的超集 返回ture
//swift2.2
//set7.isSupersetOf(set5)
//swift3.0
set7.isSuperset(of: set5)
//判断是否是某个集合的真子集 set5是set7的真子集 返回ture
//swift2.2
//set5.isStrictSubsetOf(set7)
//swift3.0
set5.isStrictSubset(of: set7)
//判断是否是某个集合的真超集 set7不是set8的真超集 返回false
//swift2.2
//set7.isStrictSupersetOf(set8)
//swift3.0
set7.isStrictSuperset(of: set8)

for item in set7 {
    print(item)
}
//swift3.0
for item in set7.enumerated() {
    print(item)
}
for index in set7.indices {
    print(set7[index])
}
//从大到小排序遍历结合
//swift3.0
for item  in set7.sorted(by: >){
    print(item)
}

/*
 3.工程测量到两组数据，分别为2、4、3、5与3、4、7、1。对两组数据进行整合，使其合成为一组数据，重复的数据只算一次，使用代码描述上述过程
 */
var setOri3:Set<Int> = [2,4,3,5]
var setOri32:Set<Int> = [3,4,7,1]
var setRes3 = setOri3.union(setOri32)

//声明字典[param1:param2]这种结构用于表示字典类型 param1为键类型 param2为值类型
var dic1:[Int:String]
//这种方式和[:]效果一样 dic2与dic1为相同的类型
var dic2:Dictionary<Int,String>
//字典创建与赋值
dic1 = [1:"1",2:"2",3:"3"]
dic2 = Dictionary(dictionaryLiteral: (1,"1"),(2,"2"),(3,"3"))
//在创建字典时，也可以不显示声明字典的类型，可以通过赋初值的方式来使编译器自动推断
var dic3 = ["1":"one"]
//创建空字典
var dic4:[Int:Int] = [:]
var dic5:Dictionary<Int,Int> = Dictionary()
//获取字典中元素个数
dic1.count
//判断字典是否为空
if dic4.isEmpty{
    print("字典为空")
}
//通过键操作值
//获取值
dic1[1]
//修改值
dic1[1]="0"
//添加一对新的键值
dic1[4] = "4"

//对键值进行更新
dic1.updateValue("1", forKey: 1)
//使用if let 处理updateValue的返回值
if let oldValue = dic1.updateValue("One", forKey: 1) {
    print("Old Value is \(oldValue)")
}
//通过键获取的数据也将返回Optional类型的值 也可以使用if let
if let value = dic2[1] {
    print("The Value is \(value)")
}

//通过键删除某个键值对
//swift2.2
//dic1.removeValueForKey(1)
//swift3.0
dic1.removeValue(forKey: 1)
//删除所有键值对
dic1.removeAll()

//通过键来遍历字典
for item in dic2.keys {
    print(item)
}
//通过值来遍历字典
for item in dic2.values {
    print(item)
}
//直接遍历字典
for item in dic2 {
    print(item)
}
for (key,value) in dic2 {
    print("\(key):\(value)")
}
//swift3.0
for item in dic2.keys.sorted(by: >){
    print(dic2[item])
}

/*
 4.期末考试中，王晓成绩98，邹明成绩86，李小伟成绩93，用字典结构来对三人的成绩进行存储，并进行从高到低的排序输出。
 */
//swift3.0
var dicOri4 = ["王晓":98,"邹明":86,"李小伟":93]
for item in dicOri4.sorted(by: { (student1, student2) -> Bool in
    return student1.value > student2.value
}){
    print(item)
}
