//函数闭包
package main

import (
	"fmt"
)

/**
子函数内部可以读取操作父函数的变量
*/
func main() {
	nextNumber := getSequence() //nextNumber 是一个函数，可调用
	fmt.Println(nextNumber())
	fmt.Println(nextNumber())
	f := getSequence()
	fmt.Println(f())
	fmt.Println(f())
	fmt.Println(nextNumber())
}

//序列函数
func getSequence() func() int {
	//父函数变量
	i := 0
	return func() int {
		i += 1
		return i
	}
}
