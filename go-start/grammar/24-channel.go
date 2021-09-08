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
	go func() {
		for i := 0; i < 10; i++ {
			c1 <- i //向通道c1写入数据
			time.Sleep(time.Second * 1)
		}
		close(c1) //关闭c1
	}()
	//计算平方的Goroutine
	go func() {
		for {
			num, ok := <-c1 //读c1数据
			if ok {
				c2 <- num * num //将平方写入c2
			} else {
				break //如果c1关闭，则结束等待
			}

		}
		close(c2) //关闭c2

	}()
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
