package main

import (
	"fmt"
)

/**
goroutine 不受CPU核心数的限制
*/
func main() {
	fmt.Println("begin call goroutine")
	//启动goroutine go +func
	go func() {
		fmt.Println("I am a goroutine!")
	}()
	//main执行完还没执行goroutine
	//time.Sleep(time.Second * 1) //睡眠1s
	fmt.Println("end call goroutine")
	//进程：最小的系统资源申请单位
	//线程：最小的执行单位
	//只要你愿意 可以随意启动无限多个Goroutine
	//goroutine比线程还要小的执行单位
	//操作系统层面、线程是最小的单位、go调度算法回为每个线程提供一个goroutine的执行列表
}
