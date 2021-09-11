package eths

import (
	"fmt"
	"hdwallet"
	"log"
	"math/big"
	"strings"

	"github.com/ethereum/go-ethereum/accounts/abi/bind"
	"github.com/ethereum/go-ethereum/common"
	"github.com/ethereum/go-ethereum/ethclient"
)

var PXA_ADDR = "0x36828345e39ADe9b9645aB993d179AA40a98cbf1"
var PXC_ADDR = "0x9c822d4AE6E5Ec17B8b9a8A2b9032CcFfF0192Ad"

//Geth客户端全局连接句柄
var ethcli *ethclient.Client

// PXA合约全局实例
var instancePXA *Pxa721

// PXC合约全局实例
var instancePXC *Pxc20

func init() {
	cli, err := ethclient.Dial("http://localhost:8545")
	if err != nil {
		log.Panic("Failed to ethclient.Dial ", err)
	}
	ethcli = ethcli
	instance, err := NewPxa721(common.HexToAddress(PXA_ADDR), cli)
	if err != nil {
		log.Panic("Failed to NewPxa721", err)
	}
	instancePXA = instance
	ins, err := NewPxc20(common.HexToAddress(PXC_ADDR), cli)
	if err != nil {
		log.Panic("Failed to NewPxa721", err)
	}
	instancePXC = ins
}

//上传图片调用
func UploadPic(from, pass, to string, tokenid *big.Int) error {
	//3. 设置签名 -- 需要owner的keystore文件
	w, err := hdwallet.LoadWalletByPass(from, "./data", pass)
	if err != nil {
		fmt.Println("failed to LoadWalletByPass", err)
		return err
	}
	auth := w.HdKeyStore.NewTransactOpts()
	//4. 调用
	_, err = instancePXA.UploadMint(auth, common.HexToAddress(to), tokenid)
	if err != nil {
		fmt.Println("failed to UploadMint  ", err)
		return err
	}
	return nil
}

const adminkey = `{"address":"3f8712acd6ed891ec329fd5ae0a93dd713237e5d","crypto":{"cipher":"aes-128-ctr","ciphertext":"623b85925792e49ac809f474c96a6dc46080d865e5fe1fa89df6c3410fbbfda1","cipherparams":{"iv":"4f0521483a5577b1573f0f63d88b0ede"},"kdf":"scrypt","kdfparams":{"dklen":32,"n":4096,"p":6,"r":8,"salt":"c8ac5e6ee11526b43c2b66a44d0c0bd006fdaff23d22bd64e968406f61e38244"},"mac":"5fd86fc981d37bda5fdab0374db7916244b3dbb3eb71e92b9b6e509e21f9f009"},"id":"2785cb09-649d-4deb-88d2-de152eb78bd5","version":3}`
const adminAddr = "0x3f8712acd6ed891ec329fd5ae0a93dd713237e5d"

//授权
func SetApprove(from, pass string, tokenid *big.Int) error {

	//3. 设置签名 -- 需要owner的keystore文件
	w, err := hdwallet.LoadWalletByPass(from, "./data", pass)
	if err != nil {
		fmt.Println("failed to LoadWalletByPass", err)
		return err
	}
	auth := w.HdKeyStore.NewTransactOpts()
	//4. 调用
	_, err = instancePXA.Approve(auth, common.HexToAddress(adminAddr), tokenid)
	if err != nil {
		fmt.Println("failed to Approve  ", err)
		return err
	}
	return nil
}

//转移erc20
func TransferPXC(from, pass, to string, value *big.Int) error {
	//3. 设置签名 -- 需要owner的keystore文件
	w, err := hdwallet.LoadWalletByPass(from, "./data", pass)
	if err != nil {
		fmt.Println("failed to LoadWalletByPass", err)
		return err
	}
	auth := w.HdKeyStore.NewTransactOpts()
	//4. 调用
	_, err = instancePXC.Transfer(auth, common.HexToAddress(to), value)
	if err != nil {
		fmt.Println("failed to Transfer  ", err)
		return err
	}
	return nil
}

//转移erc721
func PartTransferPXA(from, to string, tokenid, weight, price *big.Int) error {
	//3. 设置签名 -- 需要owner的keystore文件
	keyin := strings.NewReader(adminkey)
	auth, err := bind.NewTransactor(keyin, "123")
	//4. 调用
	_, err = instancePXA.PartTransferFrom(auth, common.HexToAddress(from), common.HexToAddress(to), tokenid, weight, price)
	if err != nil {
		fmt.Println("failed to TransferPXA  ", err)
		return err
	}
	return nil
}
