package main

import (
	"fmt"
)

func main() {
	//go：基于包、面向工程编程的静态强类型、编译型、并发型、简单型开发效率、接近c运行效率、并具有垃圾回收功能的语言
	//{}永远不会在同一行
	//面向工程：一个目录只能还有一个main函数
	//go build --- 可执行文件--- go 执行
	//go run -- 临时的可执行文件 ---运行后删除
	fmt.Println("hello world")
	/**
		数据类型

	布尔类型 true false

	整型
		 uint8: 0-255       int8: -128-127
		 uint16: 0-65535    int16: -32768-32767
		 uint32: 0-4294967295   int32: -2147483648-2147483647
		 uint64: 0-18446744073709551615  int64: -9223372036854775808-9223372036854775807
		 uint:  32位系统 64位系统  int

	浮点和复数
	   float32 float64 complex32 complex64
	   byte
	   rune
	   string
	   uintptr 存放指针
	*/
}
