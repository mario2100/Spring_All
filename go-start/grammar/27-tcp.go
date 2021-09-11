package main

import (
	"fmt"
	"log"
	"net"
)

func handle_conn(conn net.Conn) {
	defer conn.Close()
	fmt.Println("New connect ", conn.RemoteAddr())
	//通信
	buf := make([]byte, 256)
	for {
		//从网络中读
		n, err := conn.Read(buf)
		if err != nil {
			fmt.Println("Failed to read", err)
			break
		}
		fmt.Printf("size:%d, msg:%s", n, string(buf[:n]))
		//写回网络 -- 回射服务器
		n, err = conn.Write(buf[:n])
		if err != nil {
			fmt.Println("Failed to Write", err)
			break
		}
	}
}
/**
服务端
 */
func main() {
	//1. 绑定IP+端口，设置侦听
	listener, err := net.Listen("tcp", "localhost:8888")
	if err != nil {
		log.Panic("Failed to Listen", err)
	}
	//延迟关闭 finally
	defer listener.Close()
	//2. 循环等待新连接
	for {
		//从连接列表获取新连接
		conn, err := listener.Accept()
		if err != nil {
			fmt.Println("Failed to Accept ", err)
		}
		//3. 与新连接通信 goroutine
		go handle_conn(conn)
	}
}

//将defer放入延迟调用栈将其后面跟随的语句进行延迟处理，
//在 defer 归属的函数即将返回时，将延迟处理的语句按 defer 的逆序进行执行，
//也就是说，先被 defer 的语句最后被执行，最后被 defer 的语句，最先被执行。
//func main() {
//	fmt.Println("defer begin")
//	// 将defer放入延迟调用栈
//	defer fmt.Println(1)
//	defer fmt.Println(2)
//	// 最后一个放入, 位于栈顶, 最先调用
//	defer fmt.Println(3)
//	fmt.Println("defer end")
//}
