package main

import (
	"fmt"
)

type Person3 struct {
	name  string
	age   int
	sex   string
	fight int
}

type Superman2 struct {
	strength int
	speed    int
	//here
	Person3
}

func (p *Person3) setAge(age int) {
	p.age = age
}

func (s *Superman2) print() {
	fmt.Printf("%+v\n", s)
}

func main() {
	p1 := Person3{"战五渣", 30, "man", 5}
	s1 := Superman2{
		strength: 100000,
		speed:    19000,
		//勘误 		p: p1,
		//结构体同名赋值
		Person3: p1,
	}
	s1.setAge(23)
	s1.print()
}
