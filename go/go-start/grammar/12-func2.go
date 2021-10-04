package main

import (
	"fmt"
)

/**
符合这类型的参数时、函数作为参数传递
*/
func add_sub(a, b int, f func(a, b int) int) int {
	return f(a, b)
}

func add(a, b int) int {
	return a + b
}

func sub(a, b int) int {
	return a - b
}


func main() {
	//有小括号传值时调用了匿名函数
	c := func(a, b int) int {
		return a + b
	}(10, 20)
	fmt.Println(c)
	//符合这类型的参数时、函数作为参数传递
	add_sub(10, 20, add) //10 + 20
	add_sub(10, 20, sub) //10 - 20
	fmt.Println(c)
}
