package main

import (
	"fmt"
)

func main2() {
	//1. 创建钱包地址
	wallet := NewWallet()
	from := fmt.Sprintf("%s", wallet.GetAddress())

	bc := CreateBlockChain(from)
	defer bc.db.Close()
	//2. 获取叶开余额
	bc.getBalance(from)
}

func main() {
	cli := NewCli()
	cli.Run()
}
