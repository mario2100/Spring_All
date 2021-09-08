package main

import "fmt"

/**
键值对数据结构
 无序集合
*/
func main() {
	//make build map
	countryCapitalMap := make(map[string]string)
	// map插入key - value对,各个国家对应的首都
	countryCapitalMap["France"] = "Paris"
	countryCapitalMap["Italy"] = "Roma"
	countryCapitalMap["China"] = "BeiJing"
	countryCapitalMap["India "] = "New Delhi"
	fmt.Println(countryCapitalMap)
	//map usage
	val := countryCapitalMap["France"]
	fmt.Println(val)
	//指示器
	val, ok := countryCapitalMap["France"]
	//是否存在
	fmt.Println(ok)
	fmt.Println(val)

	//遍历
	for k, v := range countryCapitalMap {
		fmt.Println(k, "'s capital is", v)
	}
	//占位符
	for _, v := range countryCapitalMap {
		fmt.Println(v)
	}

	a := []int{1, 2, 3, 4, 5, 6}
	for index, val := range a {
		fmt.Printf("a[%d]=%d\n", index, val)
	}
}
