package main

import (
	"fmt"
)

func main() {
	a, b := 10, 20
	fmt.Printf("%d + %d = %d\n", a, b, add_1(a, b))
}

/**
顺序无关性
*/
func add_1(a int, b int) int {
	return a + b
}
