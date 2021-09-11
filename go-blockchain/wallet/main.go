package main

import (
	"wallet/cli"
)

func main() {
	cli := cli.NewCli("./keystore", "http://localhost:8545")
	cli.Run()
}
