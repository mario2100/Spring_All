module copyright

go 1.12

require (
	github.com/btcsuite/btcutil v1.0.2 // indirect
	github.com/ethereum/go-ethereum v1.9.12
	github.com/go-sql-driver/mysql v1.5.0
	github.com/gorilla/sessions v1.2.0
	github.com/howeyc/gopass v0.0.0-20190910152052-7cb4b85ec19c // indirect
	github.com/labstack/echo/v4 v4.1.16
	github.com/tyler-smith/go-bip39 v1.0.2 // indirect
	hdwallet v0.0.0-00010101000000-000000000000
	wallet/hdkeystore v0.0.0-00010101000000-000000000000 // indirect
)

replace hdwallet => ../wallet/hdwallet

replace wallet/hdkeystore => ../wallet/hdkeystore
