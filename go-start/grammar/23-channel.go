package main

import (
	"fmt"
	"sync"
	"time"
)

var c chan string
var w sync.WaitGroup

func reader() {
	msg := <-c //读通道
	fmt.Println("I am reader,", msg)
	w.Done()
}

func main() {
	c = make(chan string)
	w.Add(1)
	go reader()
	fmt.Println("begin sleep")
	time.Sleep(time.Second * 3) //睡眠3s为了看执行效果
	c <- "hello"                //写通道
	w.Wait()                    //等待reader结束
}
