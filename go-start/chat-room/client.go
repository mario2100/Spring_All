package main

import (
	"bufio"
	"encoding/json"
	"fmt"
	"log"
	"net"
	"os"
	"strings"
	"unsafe"
)

//客户端发送消息结构
type ClientMsg struct {
	To      string  `json:"To"`      //接受者
	Msg     string  `json:"Msg"`     //消息
	DataLen uintptr `json:"DataLen"` //消息长度
}

func help() {
	fmt.Println("1. set:your name")
	fmt.Println("2. all:your msg -- broadcast")
	fmt.Println("3. anyone:your msg-- private msg")
}

func handleServerConn(conn net.Conn) {
	buf := make([]byte, 256)
	for {
		n, err := conn.Read(buf)
		if err != nil {
			log.Panic("Failed tpo Read", err)
		}
		fmt.Println(string((buf[:n])))
		fmt.Println("SK's chat >")
	}
}

func main() {
	//拨号连接
	conn, err := net.Dial("tcp", "localhost:8888")
	if err != nil {
		log.Panic("Failed tpo Dial", err)
	}
	defer conn.Close()
	go handleServerConn(conn)
	reader := bufio.NewReader(os.Stdin)
	fmt.Println("welcome to SK's pub chat\n")
	help()
	for {
		fmt.Println("SK's chat >")
		msg, err := reader.ReadString('\n')
		if err != nil {
			log.Panic("Failed to ReadString", err)
		}
		//取消换行回车
		msg = strings.Trim(msg, "\r\n")
		if msg == "quit" {
			fmt.Println("bye bye")
			break
		}
		if msg == "help" {
			help()
			continue
		}
		msgs := strings.Split(msg, ":")
		if len(msgs) == 2 {
			var clientMsg ClientMsg
			clientMsg.To = msgs[0]
			clientMsg.Msg = msgs[1]
			clientMsg.DataLen = unsafe.Sizeof(clientMsg)
			//序列化
			data, err := json.Marshal(clientMsg)
			if err != nil {
				fmt.Println("Failed to Marshal", err, clientMsg)
				continue
			}
			_, err = conn.Write(data)
			if err != nil {
				fmt.Println("Failed to Write", err, clientMsg)
				break
			}
		}
	}
}
