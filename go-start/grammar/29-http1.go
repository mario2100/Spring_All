package main

import (
	"fmt"
	"net"
)

func main() {
	listener, _ := net.Listen("tcp", ":8080")
	for {
		conn, _ := listener.Accept()
		go func(conn net.Conn) {
			buf := make([]byte, 2048)
			conn.Read(buf)
			fmt.Println(string(buf))
		}(conn)
	}
}
