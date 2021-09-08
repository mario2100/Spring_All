package main

import (
	"fmt"
)

/**
类c 指针操作值
*/
func main() {
	var a int = 10
	fmt.Println(a)
	//指针相等、指向同一内存位置
	p := &a
	*p = 100
	fmt.Println(a, *p)
}
