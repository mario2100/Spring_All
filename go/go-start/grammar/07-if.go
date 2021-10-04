package main

import (
	"fmt"
)

/**
简化 判断条件没括号
*/
func main() {
	var a = 10
	if a > 10 {
		fmt.Println("a bigger than 10.")
	} else if a < 10 {
		fmt.Println("a less than 10.")
	} else {
		fmt.Println("a equal 10.")
	}
}
