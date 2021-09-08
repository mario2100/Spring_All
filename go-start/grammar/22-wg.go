package main

import (
	"fmt"
	"sync"
	"time"
)

var w sync.WaitGroup

func main() {
	for i := 0; i < 10; i++ {
		w.Add(1) 
		go func(num int) {
			time.Sleep(time.Second * time.Duration(num))
			fmt.Printf("I am %d Goroutine\n", num)
			w.Done() 
		}(i)
	}

	w.Wait() 
}
