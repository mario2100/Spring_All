package main

import (
	"fmt"
	"net"
	"os"
)

func main() {
	//1. 第一步建立连接
	conn, err := net.Dial("tcp", "localhost:8888")
	if err != nil {
		fmt.Println("Failed to Dial")
		return
	}
	//延迟关闭conn
	defer conn.Close()
	//2. 与服务端通信
	buf := make([]byte, 256)
	for {
		//2.1 读标准输入
		n, _ := os.Stdin.Read(buf)
		//2.2 写到网络
		conn.Write(buf[:n])
		//2.3 读网络
		n, _ = conn.Read(buf)
		//2.4 打印到屏幕
		os.Stdout.Write(buf[:n])
	}
}
