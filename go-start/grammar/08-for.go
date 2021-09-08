package main

import (
	"fmt"
	"time"
)

/*
一个for 关键字搞定所有循环
*/
func main() {
	sum := 0
	i := 0

	for i = 1; i <= 100; i++ {
		sum += i
	}
	fmt.Println("sum===", sum)

	i = 1
	sum = 0
	for i <= 100 {
		sum += i
		i++
	}
	i = 1
	sum = 0
	for {
		sum += i
		i++
		if i > 100 {
			break
		}
	}

	fmt.Println("sum===", sum)
	//每隔1s打印haha
	i = 10

	for {
		fmt.Println("haha")
		time.Sleep(time.Second * 1)
		i--
		if i == 0 {
			break
		}
	}
}
