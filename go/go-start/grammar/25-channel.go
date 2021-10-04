package main

import (
	"fmt"
	"time"
)

var c1 chan int
var c2 chan int

/**
不同的Goroutine 对channel操作分工
*/
//func main() {
//	c1 = make(chan int)
//	c2 = make(chan int)
//	//数数的Goroutine
//	go func(in chan<- int) {
//		for i := 0; i < 10; i++ {
//			c1 <- i //向通道c1写入数据
//			time.Sleep(time.Second * 1)
//		}
//		//写端关闭
//		//关闭c1
//		close(in)
//	}(c1)
//	//计算平方的Goroutine
//	go func(in <-chan int, out chan<- int) {
//		for {
//			//send
//			num, ok := <-in //读c1数据
//			if ok {
//				//write
//				out <- num * num //将平方写入c2
//			} else {
//				break //如果c1关闭，则结束等待
//			}
//
//		}
//		//写端关闭
//		close(out) //关闭c2
//	}(c1, c2)
//	//main最后负责打印
//	for {
//		num, ok := <-c2
//		if ok {
//			fmt.Println(num)
//		} else {
//			break //如果c2关闭，则结束等待
//		}
//	}
//}

/**
计时器
*/
func main() {
	ticker := time.NewTicker(time.Second)
	num := 5
	for {
		//空读 无人接收
		<-ticker.C
		fmt.Println(num)
		num--
		if num == 0 {
			break
		}
	}
	ticker.Stop()
	//5 4 3 2 1
	launch()
}

func launch() {
	fmt.Println("发射！")

}
