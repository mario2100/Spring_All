package main

import (
	"fmt"
	"time"
)

var channel1 chan int
var channel2 chan int

/**
channel 阻塞机制
*/
func main() {
	channel1 = make(chan int)
	channel2 = make(chan int)
	//数数的Goroutine
	go func() {
		for i := 0; i < 10; i++ {
			channel1 <- i //向通道c1写入数据
			time.Sleep(time.Second * 1)
		}
		//写端关闭
		close(channel1) //关闭c1
	}()
	//计算平方的Goroutine
	go func() {
		for {
			num, ok := <-channel1 //读c1数据
			if ok {
				channel2 <- num * num //将平方写入c2
			} else {
				break //如果c1关闭，则结束等待
			}
		}
		//写端关闭
		close(channel2) //关闭c2
	}()
	//main最后负责打印
	for {
		num, ok := <-channel2
		if ok {
			fmt.Println(num)
		} else {
			break //如果c2关闭，则结束等待
		}
	}
}
