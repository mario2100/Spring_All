package main

import (
	"fmt"
)

func main() {
	//创世块初始化区块链
	bc := NewBlockChain()
	//创建2个块记录2笔交易
	bc.AddBlock("Send 1 BTC to Yekai")
	bc.AddBlock("Send 2 more BTC to Fuhongxue")

	//区块链遍历
	for _, block := range bc.blocks {
		fmt.Printf("Prev. hash: %x\n", block.PrevBlockHash)
		fmt.Printf("Data: %s\n", block.Data)
		fmt.Printf("Hash: %x\n", block.Hash)
		fmt.Println()
	}
}
