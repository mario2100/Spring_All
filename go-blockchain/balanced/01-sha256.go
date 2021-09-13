package main

import (
	"crypto/sha256"
	"fmt"
)

func main() {
	hash := sha256.Sum256([]byte("welcome to blockchain"))
	fmt.Printf("%x\n", hash)

	//比特币使用算法
	//第二代sha2
	//第三代sha3 keccak 以太坊加密算法
	//base58 比特币钱包加密地址
}
