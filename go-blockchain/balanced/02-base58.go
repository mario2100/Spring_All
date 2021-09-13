package main

import (
	"fmt"
	"math/big"
)

var b58Alphabet = []byte("123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz")

func ReverseBytes(data []byte) {
	for i, j := 0, len(data)-1; i < j; i, j = i+1, j-1 {
		data[i], data[j] = data[j], data[i]
	}
}

//编码
func Base58Encode(input int64) []byte {
	var result []byte
	x := big.NewInt(input)
	//计算除数
	base := big.NewInt(int64(len(b58Alphabet)))
	//获取big.Int类型的0
	zero := big.NewInt(0)
	//用于存储余数
	mod := &big.Int{}
	//求余运算
	for x.Cmp(zero) != 0 {
		x.DivMod(x, base, mod)
		result = append(result, b58Alphabet[mod.Int64()])
	}
	ReverseBytes(result)
	return result

}

func main() {
	result := Base58Encode(258)
	fmt.Println(string(result))
}
