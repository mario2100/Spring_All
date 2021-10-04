package main

import (
	"fmt"
)

/**
这个switch 没break
*/
func main() {

	var fruit string
	fmt.Println("Please input a fruit's name")
	fmt.Scanf("%s", &fruit) //接收标准输入
	switch fruit {
	case "apple":
		fmt.Println("I want 2 apple")
	case "banana":
		fmt.Println("I want 1 banana")
	case "pear":
		fmt.Println("I want 5 pear")
	case "orange":
		fmt.Println("I want 3 orange")
	default:
		fmt.Println("Are you kiding me?")
	}

}
