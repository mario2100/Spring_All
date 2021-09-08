package main

import (
	"io"
	"log"
	"net/http"
)

// hello world, the web server
func HelloServer(w http.ResponseWriter, req *http.Request) {
	io.WriteString(w, "hello, world!\n")
}
func ByeServer(w http.ResponseWriter, req *http.Request) {
	io.WriteString(w, "Bye, Bye!\n")
}
func main() {
	http.HandleFunc("/hello", HelloServer) //设置路由
	http.HandleFunc("/bye", ByeServer)     //设置路由
	err := http.ListenAndServe(":8080", nil)
	if err != nil {
		log.Fatal("ListenAndServe: ", err)
	}
}
