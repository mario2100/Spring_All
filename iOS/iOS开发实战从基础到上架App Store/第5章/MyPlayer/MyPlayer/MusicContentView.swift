//
//  MusicContentView.swift
//  MyPlayer
//
//  Created by vip on 17/2/11.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit

class MusicContentView: UIView,UITableViewDelegate,UITableViewDataSource{
    //歌曲列表数据源
    var titleDataArray=Array<String>(){
        didSet{
            titleTableView?.reloadData()
        }
    }
    //播放器引擎对象
    var play:MyMusicPlayer?
    //设置当前界面显示的歌词 对应歌曲播放的相应时间
    func currentLRC(array:Array<LRCItem>,index:Int)  {
        let lineLRC = array[index].lrc
        if lrcLabel?.text == lineLRC {
            return
        }
        lrcLabel?.text = lineLRC
        //进行行数设置
        var lrcStr = String()
        if index<lines!/2 {
            //前面用\n补齐
            let offset = lines!/2-index
            for _ in 0..<offset{
               lrcStr.append("\n")
            }
            for j in 0..<lines!-offset{
               lrcStr = lrcStr.appendingFormat("%@\n", array[j].lrc)
            }
        }else if array.count-1-index < lines!/2{
            //后面用\n补齐
            let offset = lines!/2-(array.count-index-1)
            for j in index-(lines!/2)..<array.count {
                lrcStr = lrcStr.appendingFormat("%@\n", array[j].lrc)
            }
            for _ in 0..<offset {
                lrcStr.append("\n")
            }
        }else{
            for j in 0..<lines! {
                lrcStr.append(array[index-lines!/2+j].lrc)
                lrcStr.append("\n")
            }
        }
        let attriStr = NSMutableAttributedString(string: lrcStr)
        
        let nsText = lrcStr as NSString
        let range = nsText.range(of: array[index].lrc)
        attriStr.setAttributes([NSForegroundColorAttributeName:UIColor.green], range: range)
        
        lrcView?.attributedText = attriStr
        lrcIMGLabel?.attributedText = attriStr
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //设置分区数为1
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //设置行数味儿数据源中的数据个数
        return self.titleDataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cellId")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cellId")
            cell?.backgroundColor = UIColor.clear
            cell?.textLabel?.textColor = UIColor.white
            cell?.selectionStyle = .none
        }
        cell?.textLabel?.text = self.titleDataArray[indexPath.row]
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.play?.play(atIndex: indexPath.row, playing: self.play!.isPlaying)
    }
    
    
    private var scrollView:UIScrollView?
    //歌曲列表表格视图
    private var titleTableView:UITableView?
    //单行显示的歌词显示标签
    private var lrcLabel:UILabel?
    //锁屏图片中的歌词便签
    private var lrcIMGLabel:UILabel?
    //锁屏图片的背景
    private var lrcIMGbg:UIImageView?
    //多行显示的歌词显示标签
    private var lrcView:UILabel?
    //多行显示的歌词视频的显示行数
    private var lines:Int?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //设置视图背景为透明色
        self.backgroundColor = UIColor.clear
        //初始化滚动视图
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        self.addSubview(scrollView!)
        scrollView?.backgroundColor = UIColor.clear
        //初始化歌曲列表
        titleTableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.frame.width-90, height: self.frame.height-40), style: .plain)
        titleTableView?.backgroundColor = UIColor.clear
        titleTableView?.delegate = self
        titleTableView?.dataSource = self
        //设置表格视图行间无分割线
        titleTableView?.separatorStyle = .none
        scrollView?.addSubview(titleTableView!)
        //设置滚动视图的可滚动范围
        scrollView?.contentSize = CGSize(width: self.frame.width*2, height: self.frame.height)
        scrollView?.showsHorizontalScrollIndicator = false
        //设置滚动视图的翻页效果
        scrollView?.isPagingEnabled = true
        //初始化单行显示的歌词控件
        lrcLabel = UILabel(frame: CGRect(x: 20, y: self.frame.height-50, width: self.frame.width-40, height: 50))
        lrcLabel?.backgroundColor = UIColor.clear
        //设置歌词颜色为白色
        lrcLabel?.textColor = UIColor.white
        scrollView?.addSubview(lrcLabel!)
        lrcLabel?.textAlignment = .center
        lrcLabel?.numberOfLines = 0
        //初始化多行显示的歌词控件
        lrcView = UILabel(frame: CGRect(x: frame.width+20, y: 50, width: frame.width-40, height: frame.height-100))
        //根据屏幕尺寸获取显示行数
        lines = Int(lrcView!.frame.height/21);
        lrcView?.numberOfLines = lines!
        lrcView?.textAlignment = .center
        lrcView?.textColor = UIColor.white
        scrollView?.addSubview(lrcView!)
        //初始化锁屏图片上的歌词标签
        lrcIMGLabel = UILabel(frame: CGRect(x: 20, y: 0, width: frame.width-40, height: frame.height))
        lrcIMGLabel?.numberOfLines = lines!
        lrcIMGLabel?.textAlignment = .center
        lrcIMGLabel?.textColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
