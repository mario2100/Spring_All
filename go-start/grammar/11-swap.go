package main

import (
	"fmt"
)

func main() {

	a, b := 10, 20
	/**
	值传递
	并未改变原有值
	*/
	swap3(a, b)
	fmt.Println(a, b)

	//& 指针
	//*p 指针指向值、操作值即修改值
	swap(&a, &b)
	fmt.Println(a, b)

	//一定要用a和b去接收返回值
	a, b = swap2(a, b)
	fmt.Println(a, b)
}

/**
极简写法
*/
func swap2(a, b int) (int, int) {
	return b, a
}

/**
指针操作
修改值
*/
func swap(a, b *int) {
	temp := *a
	*a = *b
	*b = temp
}

func swap3(a, b int) {
	temp := a
	a = b
	b = temp
}
