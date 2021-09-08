package main

import (
	"fmt"
	"time"
)

var c1 chan int
var c2 chan int

func main() {
	c1 = make(chan int)
	c2 = make(chan int)
	//数数的Goroutine
	go func(out chan<- int) {
		for i := 0; i < 10; i++ {
			c1 <- i //向通道c1写入数据
			time.Sleep(time.Second * 1)
		}
		close(out) //关闭c1
	}(c1)
	//计算平方的Goroutine
	go func(in, out chan<- int) {
		for {
			num, ok := <-in //读c1数据
			if ok {
				out <- num * num //将平方写入c2
			} else {
				break //如果c1关闭，则结束等待
			}

		}
		close(out) //关闭c2

	}(c1, c2)
	//main最后负责打印
	for {
		num, ok := <-c2
		if ok {
			fmt.Println(num)
		} else {
			break //如果c2关闭，则结束等待
		}

	}
}
