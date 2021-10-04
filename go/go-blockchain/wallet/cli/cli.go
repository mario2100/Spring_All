package cli

import (
	"context"
	"flag"
	"fmt"
	"log"
	"math/big"
	"os"
	"strings"
	"wallet/hdwallet"
	"wallet/sol"

	"github.com/ethereum/go-ethereum"
	"github.com/ethereum/go-ethereum/accounts/abi/bind"
	"github.com/ethereum/go-ethereum/common"
	"github.com/ethereum/go-ethereum/core/types"
	"github.com/ethereum/go-ethereum/crypto"
	"github.com/ethereum/go-ethereum/ethclient"
)

type Cli struct {
	KeyDir      string
	NetworkAddr string //节点地址
}

func NewCli(keyDir, networkAddr string) *Cli {
	return &Cli{keyDir, networkAddr}
}

func help() {
	fmt.Println("./wallet createwallet -pass PASSWORD  -- create wallet by password")
	fmt.Println("./wallet transfer -from FROM -toaddr TOADDR -value VALUE --for transfer from acct to toaddr")
	fmt.Println("./wallet balance -from FROM  --for get balance")
	fmt.Println("./wallet sendtoken -from FROM -toaddr TOADDR -value VALUE --for  sendtoken")
	fmt.Println("./wallet tokenbalance -from FROM --for get tokenbalance")
	fmt.Println("./wallet detail -who WHO --for get tokendetail")

}

func (c Cli) Run() {
	if len(os.Args) < 2 {
		help()
		os.Exit(0)
	}
	//1. 立flag
	createwallet_cmd := flag.NewFlagSet("createwallet", flag.ExitOnError)
	transfer_cmd := flag.NewFlagSet("transfer", flag.ExitOnError)
	balance_cmd := flag.NewFlagSet("balance", flag.ExitOnError)
	sendtoken_cmd := flag.NewFlagSet("sendtoken", flag.ExitOnError)
	tokenbalance_cmd := flag.NewFlagSet("tokenbalance", flag.ExitOnError)
	detail_cmd := flag.NewFlagSet("detail", flag.ExitOnError)
	//2. 设定解析变量
	createwallet_cmd_pass := createwallet_cmd.String("pass", "", "PASSWORD")
	// transfer
	transfer_cmd_from := transfer_cmd.String("from", "", "FROM")
	transfer_cmd_toaddr := transfer_cmd.String("toaddr", "", "TOADDR")
	transfer_cmd_value := transfer_cmd.Int64("value", 0, "VALUE")
	//coin-balance
	balance_cmd_from := balance_cmd.String("from", "", "FROM")
	//sendtoken 解析
	sendtoken_cmd_from := sendtoken_cmd.String("from", "", "FROM")
	sendtoken_cmd_toaddr := sendtoken_cmd.String("toaddr", "", "TOADDR")
	sendtoken_cmd_value := sendtoken_cmd.Int64("value", 0, "VALUE")
	//tokenbalance 解析
	tokenbalance_cmd_from := tokenbalance_cmd.String("from", "", "FROM")
	//detail参数解析
	detail_cmd_who := detail_cmd.String("who", "", "WHO")
	//3. 解析参数
	switch os.Args[1] {
	case "createwallet":
		err := createwallet_cmd.Parse(os.Args[2:])
		if err != nil {
			log.Panic("Failed to Parse createwallet_cmd.Parse", err)
		}
	case "transfer":
		err := transfer_cmd.Parse(os.Args[2:])
		if err != nil {
			log.Panic("Failed to Parse transfer_cmd.Parse", err)
		}
	case "balance":
		err := balance_cmd.Parse(os.Args[2:])
		if err != nil {
			fmt.Println("Failed to Parse balance_cmd", err)
			return
		}
	case "sendtoken":
		err := sendtoken_cmd.Parse(os.Args[2:])
		if err != nil {
			fmt.Println("Failed to Parse sendtoken_cmd", err)
			return
		}
	case "tokenbalance":
		err := tokenbalance_cmd.Parse(os.Args[2:])
		if err != nil {
			fmt.Println("Failed to Parse tokenbalance_cmd", err)
			return
		}
	case "detail":
		err := detail_cmd.Parse(os.Args[2:])
		if err != nil {
			fmt.Println("Failed to Parse detail_cmd", err)
			return
		}
	}

	//4. 确认参数是否被解析，调用业务逻辑
	if createwallet_cmd.Parsed() {
		//创建钱包逻辑
		if *createwallet_cmd_pass == "" {
			fmt.Println("Password is empty")
			return
		}
		c.CreateWallet(*createwallet_cmd_pass)
	}

	if transfer_cmd.Parsed() {
		if *transfer_cmd_from == "" ||
			*transfer_cmd_toaddr == "" ||
			*transfer_cmd_value == 0 {
			fmt.Println("transfer params err")
			return
		}
		//执行coin转移逻辑
		c.Transfer(*transfer_cmd_from, *transfer_cmd_toaddr, *transfer_cmd_value)
	}

	//处理Coin余额
	if balance_cmd.Parsed() {
		//fmt.Println(*balance_cmd_from)
		c.balance(*balance_cmd_from)
	}

	//处理sendtoken
	if sendtoken_cmd.Parsed() {
		c.sendtoken(*sendtoken_cmd_from, *sendtoken_cmd_toaddr, *sendtoken_cmd_value)
	}
	//处理tokenbalance
	if tokenbalance_cmd.Parsed() {
		c.tokenbalance(*tokenbalance_cmd_from)
	}

	//处理detail
	if detail_cmd.Parsed() {
		c.tokendetail(*detail_cmd_who)
	}

}

//创建钱包逻辑
func (c Cli) CreateWallet(pass string) {
	w, err := hdwallet.NewWallet(c.KeyDir)
	if err != nil {
		log.Panic("Failed to NewWallet ", err)
	}
	w.StoreKey(pass)
}

//coin转移
func (c Cli) Transfer(from, toaddr string, value int64) error {
	//1. 钱包加载
	w, _ := hdwallet.LoadWallet(from, c.KeyDir)
	//2. 连接到以太坊
	cli, _ := ethclient.Dial(c.NetworkAddr)
	defer cli.Close()
	//3. 获取nonce
	nonce, _ := cli.NonceAt(context.Background(), common.HexToAddress(from), nil)
	//4. 创建交易
	gaslimit := uint64(300000)
	gasprice := big.NewInt(21000000000)
	amount := big.NewInt(value)
	tx := types.NewTransaction(nonce, common.HexToAddress(toaddr), amount, gaslimit,
		gasprice, []byte("Salary"))
	//5. 签名
	stx, err := w.HdKeyStore.SignTx(common.HexToAddress(from), tx, nil)
	if err != nil {
		log.Panic("Failed to SignTx", err)
	}
	//6. 发送交易
	return cli.SendTransaction(context.Background(), stx)
}

func (c Cli) balance(from string) (int64, error) {
	//1. 连接到以太坊
	cli, err := ethclient.Dial(c.NetworkAddr)
	if err != nil {
		log.Panic("Failed to ethclient.Dial  ", err)
	}
	defer cli.Close()
	//2. 查询余额
	addr := common.HexToAddress(from)
	value, err := cli.BalanceAt(context.Background(), addr, nil)
	if err != nil {
		log.Panic("Failed to BalanceAt ", err, from)
	}
	fmt.Printf("%s's balance is %d\n", from, value)
	return value.Int64(), nil

}

const TokenContractAddr = "0x4052A1B8c9615363E51cB706bA82e3555CbF1D64"

//token转移
func (c Cli) sendtoken(from, toaddr string, value int64) error {
	//1. 连接到以太坊
	cli, _ := ethclient.Dial(c.NetworkAddr)
	defer cli.Close()
	//2. 创建token合约实例，需要合约地址
	token, _ := sol.NewToken(common.HexToAddress(TokenContractAddr), cli)
	//3. 设置调用身份
	//3.1. 钱包加载
	w, _ := hdwallet.LoadWallet(from, c.KeyDir)
	//3.2 利用钱包私钥创建身份
	auth := w.HdKeyStore.NewTransactOpts()
	//4. 调用转移
	_, err := token.Transfer(auth, common.HexToAddress(toaddr), big.NewInt(value))
	return err
}

func (c Cli) tokenbalance(from string) (int64, error) {
	//1. 连接到以太坊
	cli, err := ethclient.Dial(c.NetworkAddr)
	if err != nil {
		log.Panic("Failed to ethclient.Dial  ", err)
	}
	defer cli.Close()
	//2. 创建合约实例
	token, err := sol.NewToken(common.HexToAddress(TokenContractAddr), cli)
	if err != nil {
		log.Panic("Failed to NewToken ", err)
	}
	//3. 构建CallOpts
	fromaddr := common.HexToAddress(from)
	opts := bind.CallOpts{
		From: fromaddr,
	}

	value, err := token.BalanceOf(&opts, fromaddr)
	if err != nil {
		log.Panic("failed totoken.BalanceOf ", err)
	}
	fmt.Printf("%s's token balance is: %d\n", from, value.Int64())
	return value.Int64(), err
}

func (c Cli) tokendetail(who string) error {
	// 1. 连接到以太坊
	cli, err := ethclient.Dial(c.NetworkAddr)
	if err != nil {
		log.Panic("Failed to ethclient.Dial  ", err)
	}
	defer cli.Close()
	// 2. 先设置过滤条件，设为空
	query := ethereum.FilterQuery{
		Addresses: []common.Address{},
		Topics:    [][]common.Hash{{}},
	}
	// 3. 合约地址处理，这两个变量后面会使用
	cAddress := common.HexToAddress(TokenContractAddr)
	topicHash := crypto.Keccak256Hash([]byte("Transfer(address,address,uint256)"))
	// 4. 查询全部日志
	logs, err := cli.FilterLogs(context.Background(), query)
	if err != nil {
		log.Panic("failed to FilterLogs", err)
	}
	// 5. 过滤日志

	// for _, v := range logs {
	// 	data, err := v.MarshalJSON()
	// 	//topicHash为Transfer计算的hash值
	// 	fmt.Printf("topicHash : [0x%x]\n", topicHash)
	// 	fmt.Println(string(data), err, "\n\n")
	// }

	for _, v := range logs {
		if cAddress == v.Address {
			if len(v.Topics) == 3 {
				if v.Topics[0] == topicHash {
					fromF := v.Topics[1].Bytes()[len(v.Topics[1].Bytes())-20:]
					to := v.Topics[2].Bytes()[len(v.Topics[2].Bytes())-20:]
					val := big.NewInt(0)
					val.SetBytes(v.Data)
					if strings.ToUpper(fmt.Sprintf("0x%x", fromF)) == strings.ToUpper(who) {
						fmt.Printf(" from : 0x%x\n to : 0x%x\n value : -%d\n BlockNumber : %d\n",
							fromF, to, val.Int64(), v.BlockNumber)
					}
					if strings.ToUpper(fmt.Sprintf("0x%x", to)) == strings.ToUpper(who) {
						fmt.Printf("from : 0x%x\n to : 0x%x\n value : +%d\n BlockNumber : %d\n",
							fromF, to, val.Int64(), v.BlockNumber)
					}
				}
			}
		}
	}
	return nil
}
