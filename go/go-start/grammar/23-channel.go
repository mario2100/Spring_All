package main

import (
	"fmt"
	"sync"
	"time"
)

var c chan string
var w2 sync.WaitGroup

/**
变量类型
chan 关键字
*/
func reader() {
	msg := <-c //读通道
	fmt.Println("I am reader,", msg)
	w2.Done()
}

func main() {
	//不见不散通道的定义
	c = make(chan string)
	w2.Add(1)
	go reader()
	fmt.Println("begin sleep")
	time.Sleep(time.Second * 3) //睡眠3s为了看执行效果j
	c <- "hello"                //写通道
	w2.Wait()                   //等待reader结束
}
