package main

import (
	"copyright/routes"

	"github.com/labstack/echo/v4/middleware"

	"github.com/labstack/echo/v4"
)

var Pecho *echo.Echo //echo框架对象全局定义
//静态html文件处理
func staticFile() {

	Pecho.Static("/", "static/pc/home") //根目录设置
	Pecho.Static("/static", "static")   //全路径处理
	Pecho.Static("/upload", "static/pc/upload")
	Pecho.Static("/css", "static/pc/css")
	Pecho.Static("/assets", "static/pc/assets")
	Pecho.Static("/user", "static/pc/user")
	Pecho.Static("/contents", "static/contents")
}

func main() {
	//创建echo对象
	Pecho = echo.New()
	//安装日志中间件
	Pecho.Use(middleware.Logger())
	//安装恢复中间件
	Pecho.Use(middleware.Recover())
	//在传输时使用压缩中间件
	Pecho.Use(middleware.GzipWithConfig(middleware.GzipConfig{
		Level: 5,
	}))

	staticFile()

	Pecho.GET("/ping", routes.Ping)
	Pecho.POST("/register", routes.Register)
	Pecho.POST("/login", routes.Login)
	Pecho.GET("/session", routes.Session)
	Pecho.POST("/content", routes.Upload)
	Pecho.GET("/content", routes.GetContents) //查看用户图片

	Pecho.POST("/auction", routes.Auction)        //发起拍卖
	Pecho.GET("/auctions", routes.GetAuctions)    //查看拍卖
	Pecho.POST("/auction/bid", routes.BidAuction) //用户竞拍
	Pecho.Logger.Fatal(Pecho.Start(":9527"))
}
