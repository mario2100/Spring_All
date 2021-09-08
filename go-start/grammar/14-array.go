package main

import "fmt"

/**
just like Java Array[]
single limited num bean type
*/
//func main() {
//	//默认赋值 0
//	var a1 [5]int = [5]int{1, 2, 3, 4}
//	fmt.Println(a1)
//	a1[4] = 6 //使用数组下标对数组的第5个元素赋值
//	fmt.Println(a1)
//	s1 := [4]string{"lily", "lucy", "lilei"} //元素个数不能超过数组个数
//	fmt.Println(s1)
//}
/**
切片
slice
*/
//func main() {
//	a1 := [5]int{1, 2, 3, 4, 5}
//	//切片的定义方式之一
//	s1 := a1[2:4]
//	fmt.Println(a1)
//	//前闭后开 start到end-1
//	fmt.Println(s1)
//	//不能越界
//	s1[1] = 100
//	//切片是引用类型：切片属于原数组的部分、有着不可分割的联系
//	fmt.Println("after-------")
//	fmt.Println(a1)
//	fmt.Println(s1)
//}
/**
切片的几个方法与扩容
*/
func main() {
	var s1 []int
	s1 = append(s1, 1)
	s1 = append(s1, 2)
	s1 = append(s1, 3, 4, 5)
	printSlice(s1)
	//make([]T,len,cap) 默认len和cap一致 cap可省略
	s2 := make([]int, 3)
	printSlice(s2)
	//2倍扩容
	s2 = append(s2, 4)
	printSlice(s2)
}

func printSlice(s []int) {
	//%v 针对容器详细信息打印
	fmt.Printf("len=%d,cap=%d,s=%v\n", len(s), cap(s), s)
}
