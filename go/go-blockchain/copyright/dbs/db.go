package dbs

import (
	"database/sql"
	"fmt"
	_ "github.com/go-sql-driver/mysql"
)

type User struct {
	Email    string `json:"email"`
	Password string `json:"identity_id"`
	UserName string `json:"username"`
	Address  string `json:"address"`
}

type Content struct {
	Title       string `json:"title"`        //原图片名称
	ContentPath string `json:"content"`      //图片保存路径
	ContentHash string `json:"content_hash"` //图片hash
	Address     string `json:"address"`      //图片上传用户地址
	TokenID     string `json:"token_id"`     //图片tokenid
}

type Auction struct {
	ContentPath string `json:"content"`  //图片路径
	Address     string `json:"address"`  //图片归属账户
	TokenID     string `json:"token_id"` //图片tokenid
	Weight      int    `json:"weight"`   //拍卖百分比
	Price       int    `json:"price"`    //百分比单价
}

type AuctionHis struct {
	Buyer   string `json:"buyer"`    //拍卖者
	Address string `json:"address"`  //图片归属账户
	TokenID string `json:"token_id"` //图片tokenid
	Weight  int64  `json:"weight"`   //拍卖百分比
	Price   int64  `json:"price"`    //百分比单价
}

//数据库连接的全局变量
var DBConn *sql.DB

//init函数是本包被其他文件引用时自动执行，并且整个工程只会执行一次
func init() {
	DBConn = InitDB("root:12345678@tcp(localhost:3306)/copyright?charset=utf8", "mysql")
}

//初始化数据库连接
func InitDB(connstr, Driver string) *sql.DB {
	db, err := sql.Open(Driver, connstr)
	if err != nil {
		panic(err.Error())
	}

	if err != nil {
		panic(err.Error()) // proper error handling instead of panic in your app
	}
	return db
}

func (u User) Add() error {
	_, err := DBConn.Exec("insert into t_user(email, username, password, address) values(?,?,?,?)",
		u.Email, u.UserName, u.Password, u.Address)
	if err != nil {
		fmt.Println("failed to insert t_user ", err)
		return err
	}
	return err
}

func (u *User) Query() (bool, error) {
	rows, err := DBConn.Query("select email,address from t_user where username=? and password=?",
		u.UserName, u.Password)
	if err != nil {
		fmt.Println("failed to select t_user ", err)
		return false, err
	}
	//有结果集
	if rows.Next() {
		err = rows.Scan(&u.Email, &u.Address)
		if err != nil {
			fmt.Println("failed to scan select t_user ", err)
			return false, err
		}
		return true, nil
	}
	return false, err
}

func (c *Content) AddContent() error {
	fmt.Printf("%+v\n", c)
	_, err := DBConn.Exec("insert into t_content(title,content,content_hash,address,token_id) values(?,?,?,?,?)",
		c.Title, c.ContentPath, c.ContentHash, c.Address, c.TokenID)
	if err != nil {
		fmt.Println("failed to insert t_content ", err)
		return err
	}

	return err
}

func QueryContents(address string) ([]Content, error) {
	s := []Content{}
	// 1.查询
	rows, err := DBConn.Query("select title,content,content_hash,token_id from t_content where address =?", address)
	if err != nil {
		fmt.Println("failed to Query t_content ", err)
		return s, err
	}

	var c Content
	// 2.处理结果集
	for rows.Next() {
		err = rows.Scan(&c.Title, &c.ContentPath, &c.ContentHash, &c.TokenID)
		if err != nil {
			fmt.Println("failed to scan select t_content ", err)
			return s, err
		}
		s = append(s, c)
	}
	return s, nil
}

func (a Auction) Add() error {
	fmt.Println(a)
	_, err := DBConn.Exec("insert into t_auction(token_id,weight,price) values(?,?,?)",
		a.TokenID, a.Weight, a.Price)
	if err != nil {
		fmt.Println("failed to insert t_auction ", err)
		return err
	}
	return err
}

func QueryAuctions(address string) ([]Auction, error) {
	s := []Auction{}
	// 1.查询
	rows, err := DBConn.Query("select a.content,a.address,b.price,b.weight,a.token_id from t_content a,t_auction b where a.token_id=b.token_id and a.address <> ? and status is null", address)
	if err != nil {
		fmt.Println("failed to Query t_auction ", err)
		return s, err
	}

	var a Auction
	// 2.处理结果集
	//a.content,a.address,b.price,b.weight,a.token_id
	for rows.Next() {
		err = rows.Scan(&a.ContentPath, &a.Address, &a.Price, &a.Weight, &a.TokenID)
		if err != nil {
			fmt.Println("failed to scan select t_aution & t_content ", err)
			return s, err
		}
		s = append(s, a)
	}
	return s, nil
}

func (ah AuctionHis) Add() error {
	_, err := DBConn.Exec("insert into t_auction_his(buyer,token_id,weight,price) values(?,?,?,?)",
		ah.Buyer, ah.TokenID, ah.Weight, ah.Price)
	if err != nil {
		fmt.Println("failed to insert t_auction_his ", err)
		return err
	}
	return err
}

func (a Auction) SetAuction() error {
	_, err := DBConn.Exec("update t_auction set status = 1 where token_id = ?", a.TokenID)
	if err != nil {
		fmt.Println("failed to update t_auction ", err)
		return err
	}
	return err
}
