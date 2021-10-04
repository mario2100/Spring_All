package main

import (
	"encoding/json"
	"fmt"
	"log"
	"net"
	"unsafe"
)

//goroutine通信的消息结构
type ChatMsg struct {
	From, To, Msg string
}

//客户端发送消息结构
type ClientMsg struct {
	To      string  `json:"To"`      //接受者
	Msg     string  `json:"Msg"`     //消息
	DataLen uintptr `json:"DataLen"` //消息长度
}

//channel消息中心用
var chanMsgCenter chan ChatMsg

//连接地址列表 昵称:remoteAddr
var mapName2ClientAddr map[string]string

//连接列表
var mapClientAddr2Connections map[string]net.Conn

//主控模块
func main() {
	//初始化
	mapClientAddr2Connections = make(map[string]net.Conn)
	mapName2ClientAddr = make(map[string]string)
	chanMsgCenter = make(chan ChatMsg)

	//绑定IP 监听端口
	listener, err := net.Listen("tcp", "localhost:8888")
	if err != nil {
		log.Panic("Failed to Listen", err)
	}
	defer listener.Close()

	//启动消息中心
	go msgCenter()

	//循环等待新连接
	for {
		conn, err := listener.Accept()
		if err != nil {
			fmt.Println("Failed to Accept ", err)
			break
		}
		//创建 goroutine 服务新连接
		go handleConn(conn)
	}

}

/**
处理连接
*/
func handleConn(conn net.Conn) {
	//处理新连接
	from := conn.RemoteAddr().String()
	mapClientAddr2Connections[from] = conn
	msg := ChatMsg{from, "all", from + "->login"}
	chanMsgCenter <- msg
	//处理断开通知
	defer logout(conn, from)
	//分析消息并通知
	buf := make([]byte, 256)
	for {
		n, err := conn.Read(buf)
		if err != nil {
			fmt.Println("Failed to Read", err, from)
			break
		}
		if n > 0 {
			//获得客户端消息
			var clientMsg ClientMsg
			//json解析
			err = json.Unmarshal(buf[:n], &clientMsg)
			if err != nil {
				fmt.Println("Failed to Unmarshal", err, string(buf[:n]))
				continue
			}
			//检验消息长度
			if clientMsg.DataLen != unsafe.Sizeof(clientMsg) {
				fmt.Println("Msg format err:", clientMsg)
				continue
			}
			//组装一个消息到消息中心
			chatMsg := ChatMsg{from, "all", clientMsg.Msg}
			switch clientMsg.To {
			case "all":
			case "set":
				//消息-地址
				mapName2ClientAddr[clientMsg.Msg] = from
				chatMsg.Msg = from + " set Name=" + chatMsg.Msg + " success"
				chatMsg.From = "server"
			default:
				chatMsg.To = clientMsg.To
			}
			chanMsgCenter <- chatMsg
		}
	}
}

/**
消息中心
*/
func msgCenter() {
	for {
		//等待channel
		msg := <-chanMsgCenter
		go sendMsg(msg)
	}
}

/**
发送消息
*/
func sendMsg(msg ChatMsg) {
	//网络通信使用字节数组
	//序列化消息结构
	data, err := json.Marshal(msg)
	if err != nil {
		fmt.Println("Failed to Marshal", err, msg)
		return
	}
	if msg.To == "all" {
		//广播
		for _, v := range mapClientAddr2Connections {
			//不发自己
			if msg.From != v.RemoteAddr().String() {
				v.Write(data)
			}
		}
	} else {
		//私信
		//先通过昵称找对应的Ip
		from, ok := mapName2ClientAddr[msg.To]
		if !ok {
			fmt.Println("User not exists", msg.To)
			return
		}
		conn, ok := mapClientAddr2Connections[from]
		if !ok {
			fmt.Println("", from, msg.To)
			return
		}
		conn.Write(data)
	}
}

/**
断开连接
*/
func logout(conn net.Conn, from string) {
	defer conn.Close()
	delete(mapName2ClientAddr, from)
	//通知消息中心
	msg := ChatMsg{from, "all", from + "->logout"}
	//写入消息通道
	chanMsgCenter <- msg
}
