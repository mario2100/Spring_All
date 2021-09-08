//多态
package main

import (
	"fmt"
)

// 动物 接口
type Animal interface {
	Sleep()
	Eating()
}

//定义猫的结构体
type Cat struct {
	color string
}

func (c *Cat) Sleep() {
	fmt.Println(c.color, " cat is sleeping")
}

func (c *Cat) Eating() {
	fmt.Println(c.color, " cat is Eating")
}

type Dog struct {
	color string
}

func (c *Dog) Sleep() {
	fmt.Println(c.color, " dog is sleeping")
}

func (c *Dog) Eating() {
	fmt.Println(c.color, " dog is Eating")
}

//工厂模式
func Factory(color string, animal string) Animal {
	switch animal {
	case "dog":
		return &Dog{color}
	case "cat":
		return &Cat{color}
	default:
		return nil //返回空值
	}
}

func main() {
	c1 := Cat{"white"}
	d1 := Dog{"Black"}
	c1.Sleep()
	d1.Eating()
	// //多态
	// a1 := Factory("flower", "cat")
	// a1.Eating()
	// a2 := Factory("Green", "dog")
	// a2.Sleep()
	var a1 Animal
	a1 = &c1
	a1.Eating()
	a1 = &d1
	d1.Sleep()
}
