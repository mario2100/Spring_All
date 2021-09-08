package main

import (
	"fmt"
	"time"
)

/**
goroutine 不受CPU核心数的限制
*/
func main() {
	fmt.Println("begin call goroutine")
	//启动goroutine
	go func() {
		fmt.Println("I am a goroutine!")
	}()
	time.Sleep(time.Second * 1) //睡眠1s
	fmt.Println("end call goroutine")
}
