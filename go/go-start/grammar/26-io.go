package main

import (
	"fmt"
	"os"
)

func main() {
	//创建并打开文件
	fd, err := os.OpenFile("a.txt", os.O_RDWR|os.O_CREATE|os.O_TRUNC, 0666)
	if err != nil {
		fmt.Println("Failed to OpenFile", err)
		return
	}
	//写入字符串
	//写时读写位置跟着变
	n, err := fd.WriteString("hello world\n")
	if err != nil {
		fmt.Println("Failed to WriteString", err)
		return
	}
	fmt.Printf("write sucess %d bytes\n", n)
	//调整文件读写位置
	fd.Seek(0, os.SEEK_SET)
	//构建缓冲区
	buf := make([]byte, 20)
	//读取文件内容
	n, err = fd.Read(buf) //为什么不用  := ？
	os.Stdout.Write(buf)  //使用标准输出打印到屏幕，等同于fmt.Print
	fd.Close()            //关闭打开的文件
}
