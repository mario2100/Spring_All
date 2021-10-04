package main

import (
	"fmt"
	"sync"
	"time"
)

var w1 sync.WaitGroup

/**
goroutine的同步
*/
func main() {
	for i := 0; i < 10; i++ {
		w1.Add(1)
		go func(num int) {
			time.Sleep(time.Second * time.Duration(num))
			fmt.Printf("I am %d Goroutine\n", num)
			w1.Done()
		}(i)
	}
	w1.Wait()
}
