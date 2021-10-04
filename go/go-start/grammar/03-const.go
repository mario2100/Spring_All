package main

import (
	"fmt"
)

func main() {
	/**
	：=只用于变量赋值
	*/
	const pi = 3.14     //圆周率是常量
	var r float32 = 3.0 //定义变量半径r
	fmt.Println("area = ", r*r*pi)
	r = 4.0 //r值可以修改
	fmt.Println("area = ", r*r*pi)
}
