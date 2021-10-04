package main

import (
	"fmt"
)

type Person1 struct {
	//private 小写
	name  string //姓名
	age   int    //年龄
	sex   string //性别
	fight int    //战斗力
}

func main() {
	//定义并初始化
	p1 := Person1{"战五渣", 30, "man", 5}
	fmt.Println(p1)
	//先定义后赋值
	var p2 Person1
	p2.age = 10
	p2.name = "xiaohong"
	p2.sex = "woman"
	fmt.Printf("%+v\n", p2) //+v 的打印方式可以更详细的显示结构体内容
}
