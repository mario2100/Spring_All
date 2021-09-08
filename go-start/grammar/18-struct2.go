package main

import (
	"fmt"
)

type Person2 struct {
	name  string
	age   int
	sex   string
	fight int
}

func (p *Person2) setAge(age int) {
	p.age = age
}


type Superman1 struct {
	strength int
	speed    int
	/**
	结构体内嵌
	间接调用
	*/
	p        Person2
}

func (s *Superman1) print() {
	fmt.Printf("%+v\n", s)
}

func main() {
	p1 := Person2{"战五渣", 30, "man", 5}
	s1 := Superman1{
		strength: 100000,
		speed:    19000,
		p:        p1, //注意逗号 与}在同一行可以不用加
	}
	//	间接调用
	s1.p.setAge(3)
	s1.print()
}
