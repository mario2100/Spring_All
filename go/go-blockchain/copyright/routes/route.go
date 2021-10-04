package routes

import (
	"copyright/dbs"
	"copyright/eths"
	"copyright/utils"
	"errors"
	"fmt"
	"math/big"
	"net/http"
	"os"
	"strconv"

	"github.com/gorilla/sessions"
	"github.com/labstack/echo/v4"
)

var session *sessions.CookieStore

func init() {
	session = sessions.NewCookieStore([]byte("secret"))
}

//resp数据响应
func ResponseData(c echo.Context, resp *utils.Resp) {
	resp.ErrMsg = utils.RecodeText(resp.Errno)
	c.JSON(http.StatusOK, resp)
}

func Ping(c echo.Context) error {
	return c.String(http.StatusOK, "Pong!")
}

//注册
func Register(c echo.Context) error {
	//组织响应消息
	resp := utils.Resp{
		Errno: "0",
	}
	defer ResponseData(c, &resp)
	// 1. 解析请求数据
	user := dbs.User{}
	err := c.Bind(&user)
	if err != nil {
		fmt.Println("Failed to bind user", err)
		resp.Errno = utils.RECODE_PARAMERR
		return err
	}
	fmt.Println(user)
	// 2. 创建账户地址
	addr, err := eths.NewAcc(user.Password)
	if err != nil {
		fmt.Println("Failed to eths.NewAcc", err)
		resp.Errno = utils.RECODE_ETHERR
		return err
	}
	user.Address = addr
	// 3. 保存到数据库
	err = user.Add()
	if err != nil {
		fmt.Println("Failed to user.Add()", err)
		resp.Errno = utils.RECODE_DBERR
		return err
	}
	resp.Data = addr
	return nil
}

//登陆 POST /login {username,identity_id}
func Login(c echo.Context) error {
	//组织响应消息
	resp := utils.Resp{
		Errno: "0",
	}
	defer ResponseData(c, &resp)
	// 1. 解析请求数据
	user := dbs.User{}
	err := c.Bind(&user)
	if err != nil {
		fmt.Println("Failed to bind user", err)
		resp.Errno = utils.RECODE_PARAMERR
		return err
	}
	fmt.Println(user)
	// 2. 查询数据库
	ok, err := user.Query()
	if err != nil {
		fmt.Println("Failed to  user.Query()", err)
		resp.Errno = utils.RECODE_DBERR
		return err
	}
	if !ok {
		fmt.Println("Failed to  user or password err", err)
		resp.Errno = utils.RECODE_DBERR
		return err
	}
	// 3. session处理

	sess, _ := session.Get(c.Request(), "session")
	sess.Options = &sessions.Options{
		Path:     "/",
		HttpOnly: true,
	}
	sess.Values["address"] = user.Address
	sess.Values["password"] = user.Password
	sess.Save(c.Request(), c.Response())

	resp.Data = user.Address

	return nil
}

// GET /session
func Session(c echo.Context) error {
	var resp utils.Resp
	resp.Errno = utils.RECODE_OK
	defer ResponseData(c, &resp)
	//处理session
	sess, err := session.Get(c.Request(), "session")
	if err != nil {
		fmt.Println("failed to get session")
		resp.Errno = utils.RECODE_LOGINERR
		return err
	}
	address := sess.Values["address"]
	if address == "" {
		fmt.Println("failed to get session, user is nil")
		resp.Errno = utils.RECODE_LOGINERR
		return err
	}
	fmt.Println(address)
	return nil
}

//上传图片功能
//upload POST: /content
func Upload(c echo.Context) error {
	//1. 响应数据结构初始化
	var resp utils.Resp
	resp.Errno = utils.RECODE_OK
	defer ResponseData(c, &resp)

	// 2.1解析数据
	content := &dbs.Content{}

	h, err := c.FormFile("fileName")
	if err != nil {
		fmt.Println("failed to FormFile ", err)
		resp.Errno = utils.RECODE_PARAMERR
		return err
	}
	src, err := h.Open()
	defer src.Close()
	// 2.2 获得tokenid
	tokenid := utils.NewTokenID()
	content.TokenID = fmt.Sprintf("%d", tokenid)
	filename := fmt.Sprintf("static/contents/%s.jpg", content.TokenID)
	content.ContentPath = fmt.Sprintf("/contents/%s.jpg", content.TokenID)
	dst, err := os.Create(filename)
	if err != nil {
		fmt.Println("failed to create file ", err, content.ContentPath)
		resp.Errno = utils.RECODE_SYSERR
		return err
	}
	defer dst.Close()
	// 2.3 计算hash
	cData := make([]byte, h.Size)
	n, err := src.Read(cData)
	if err != nil || h.Size != int64(n) {
		resp.Errno = utils.RECODE_SYSERR
		return err
	}
	hash := eths.KeccakHash(cData)
	content.ContentHash = fmt.Sprintf("%x", hash)

	dst.Write(cData)
	content.Title = h.Filename

	//3. 从session获取账户地址
	sess, _ := session.Get(c.Request(), "session")
	content.Address, _ = sess.Values["address"].(string)

	pass, ok := sess.Values["password"].(string)
	if !ok || content.Address == "" || pass == "" {
		resp.Errno = utils.RECODE_LOGINERR
		return errors.New("no session")
	}

	//4. 操作mysql-新增数据
	err = content.AddContent()
	if err != nil {
		resp.Errno = utils.RECODE_DBERR
		return err
	}

	//5. 操作以太坊
	err = eths.UploadPic(content.Address, pass, content.Address, big.NewInt(tokenid))
	if err != nil {
		resp.Errno = utils.RECODE_ETHERR
		return err
	}
	return nil
}

const PAGE_MAX_PIC = 5

//查看用户所有图片
func GetContents(c echo.Context) error {
	// 1. 响应消息提前初始化
	var resp utils.Resp
	resp.Errno = utils.RECODE_OK
	defer ResponseData(c, &resp)
	// 2. 从session获得用户地址
	sess, err := session.Get(c.Request(), "session")
	if err != nil {
		fmt.Println("failed to get session")
		resp.Errno = utils.RECODE_LOGINERR
		return err
	}
	address, ok := sess.Values["address"].(string)
	if address == "" || !ok {
		fmt.Println("failed to get session,address is nil")
		resp.Errno = utils.RECODE_LOGINERR
		return err
	}
	// 3. 查询数据库
	contents, err := dbs.QueryContents(address)
	if err != nil {
		resp.Errno = utils.RECODE_DBERR
		return err
	}
	// 4. 组织响应数据内容
	total_page := int(len(contents))/PAGE_MAX_PIC + 1
	current_page := 1
	mapResp := make(map[string]interface{})
	mapResp["total_page"] = total_page
	mapResp["current_page"] = current_page
	mapResp["contents"] = contents
	resp.Data = mapResp
	return nil
}

//拍卖功能 POST:/auction
func Auction(c echo.Context) error {
	//1. 响应数据结构初始化
	var resp utils.Resp
	resp.Errno = utils.RECODE_OK
	defer ResponseData(c, &resp)

	//2. 解析数据
	auction := &dbs.Auction{}
	if err := c.Bind(auction); err != nil {
		fmt.Println(auction)
		resp.Errno = utils.RECODE_PARAMERR
		return err
	}
	fmt.Println("Auction:", auction)

	//3. session获取
	sess, err := session.Get(c.Request(), "session")
	if err != nil {
		fmt.Println("failed to get session")
		resp.Errno = utils.RECODE_LOGINERR
		return err
	}
	addr, ok := sess.Values["address"].(string)
	pass, ok := sess.Values["password"].(string)
	auction.Address = addr
	if addr == "" || !ok {
		fmt.Println("failed to get session,address is nil")
		resp.Errno = utils.RECODE_LOGINERR
		return err
	}
	//auction.Address = address
	//4. 操作mysql-新增
	err = auction.Add()
	if err != nil {
		resp.Errno = utils.RECODE_DBERR
		return err
	}
	//5. 操作eth
	strconv.ParseInt(auction.TokenID, 10, 64)
	value := big.NewInt(0)
	value, _ = value.SetString(auction.TokenID, 10)
	err = eths.SetApprove(auction.Address, pass, value)
	if err != nil {
		resp.Errno = utils.RECODE_ETHERR
		return err
	}
	return nil
}

//查看拍卖
func GetAuctions(c echo.Context) error {
	//1. 响应数据结构初始化
	var resp utils.Resp
	resp.Errno = utils.RECODE_OK
	defer ResponseData(c, &resp)
	//2.处理session
	sess, err := session.Get(c.Request(), "session")
	if err != nil {
		fmt.Println("failed to get session")
		resp.Errno = utils.RECODE_LOGINERR
		return err
	}
	address, ok := sess.Values["address"].(string)
	if address == "" || !ok {
		fmt.Println("failed to get session,address is nil")
		resp.Errno = utils.RECODE_LOGINERR
		return err
	}
	fmt.Println("GetAuctions:", address)
	//3.查询数据库
	auctions, err := dbs.QueryAuctions(address)
	if err != nil {
		resp.Errno = utils.RECODE_DBERR
		return err
	}

	resp.Data = auctions

	return nil
}

//用户竞拍
func BidAuction(c echo.Context) error {
	//1. 组织响应数据
	var resp utils.Resp
	resp.Errno = utils.RECODE_OK
	defer ResponseData(c, &resp)
	//2. 获取参数
	ah := &dbs.AuctionHis{}
	if err := c.Bind(ah); err != nil {
		resp.Errno = utils.RECODE_PARAMERR
		return err
	}
	//3. session?
	sess, err := session.Get(c.Request(), "session")
	if err != nil {
		fmt.Println("failed to get session")
		resp.Errno = utils.RECODE_LOGINERR
		return err
	}
	address, ok := sess.Values["address"].(string)
	pass, ok := sess.Values["password"].(string)
	if address == "" || !ok {
		fmt.Println("failed to get session,address is nil")
		resp.Errno = utils.RECODE_LOGINERR
		return err
	}
	ah.Buyer = address

	//4. 数据库操作
	err = ah.Add()
	if err != nil {
		resp.Errno = utils.RECODE_DBERR
		return err
	}
	//5. eth 交割
	//func TransferPXC(from, pass, to string, value *big.Int)
	err = eths.TransferPXC(address, pass, ah.Address, big.NewInt(ah.Weight*ah.Price))
	if err != nil {
		resp.Errno = utils.RECODE_ETHERR
		return err
	}
	//func PartTransferPXA(from, to string, tokenid, weight, price *big.Int)
	value := big.NewInt(0)
	value, _ = value.SetString(ah.TokenID, 10)
	err = eths.PartTransferPXA(ah.Address, address, value, big.NewInt(ah.Weight), big.NewInt(ah.Price))
	if err != nil {
		resp.Errno = utils.RECODE_ETHERR
		return err
	}
	//6. 数据库状态变更
	auction := dbs.Auction{
		TokenID: ah.TokenID,
	}
	err = auction.SetAuction()
	if err != nil {
		resp.Errno = utils.RECODE_DBERR
		return err
	}
	return nil
}
