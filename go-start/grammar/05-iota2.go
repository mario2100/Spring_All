//枚举
package main

import (
	"fmt"
)

const (
	login   = iota     // itoa = 0
	logout             //itoa = 1
	user    = iota + 1 //itoa = 2
	account = iota + 3 //itoa = 3
)

const (
	apple, banana = iota + 1, iota + 2  //itoa = 0
	peach, pear  // apple, banana = iota + 1, iota + 2  itoa = 1
	orange, mango //apple, banana = iota + 1, iota + 2  itoa = 2
)

func main() {
	fmt.Println(login, logout, user, account)
	fmt.Println(apple, banana, peach, pear, orange, mango)
}
