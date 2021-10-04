package main

import (
	"fmt"
)

/**
0 逐次增加
*/
const (
	Sun = iota
	Mon = iota
	Tue
	Wed
	Thu
	Fri
	Sat
)

func main() {
	fmt.Println(Sun, Mon, Tue, Wed, Thu, Fri, Sat)
}
