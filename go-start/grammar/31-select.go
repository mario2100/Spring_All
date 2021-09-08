package main

import (
	"fmt"
	"time"
)

func main() {
	fmt.Println("test select")
	c1 := make(chan int)
	c2 := make(chan int)
	go func() {
		time.Sleep(time.Second * 3)
		c1 <- 1
	}()
	go func() {
		time.Sleep(time.Second * 5)
		c2 <- 1
	}()
	sum := 0
	for {
		fmt.Println("for ....")
		select {
		case <-c1:
			fmt.Println("c1 ok")
			sum++
		case <-c2:
			fmt.Println("c2 ok")
			sum++
		}
		if sum >= 2 {
			break
		}
	}
}
