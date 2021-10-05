//
//  ImageTableViewCell.swift
//  MyLaugh
//
//  Created by vip on 17/1/17.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit
import Kingfisher
class ImageTableViewCell: UITableViewCell {

   
    var content:String?{
        willSet{
            let url = newValue?.addingPercentEscapes(using: .utf8)
            webImageView?.image = nil
            webImageView?.kf.setImage(with: URL(string: url!),completionHandler:{(image:Image?,error, cacheType,imageURL) in
                if(image != nil){
                    self.webImageView?.frame = CGRect(x: 0, y: 30, width: self.frame.width, height: self.frame.size.width/image!.size.width*image!.size.height)
                }else{
                    self.webImageView?.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 100)
                }
                
                self.dateLabel?.frame = CGRect(x: 0, y: self.webImageView!.frame.height+40, width: self.dateLabel!.frame.width, height: 21)
                if self.cellHeight==nil {
                    self.cellHeight = 0
                }
                if CGFloat(self.cellHeight!) != self.webImageView!.frame.size.height+61 {
                    self.cellHeight = Float(self.webImageView!.frame.height+61)
                    let noti = Notification(name: Notification.Name(rawValue:"sizeChange"), object: nil, userInfo: ["height" : String(format: "%f", self.cellHeight!),"row":String(format: "%d", self.indexRow!)])
                    NotificationCenter.default.post(noti)
                }
            })
        }
    }
    
    var indexRow:Int?
    var date:String?{
        willSet{
            dateLabel?.text = newValue
        }
    }
    var title:String?{
        willSet{
            titleLabel?.text = newValue
        }
    }
    func getHeight()->Float {
        return cellHeight!
    }
    
    
    private var webImageView:UIImageView?
    private var titleLabel:UILabel?
    private var dateLabel:UILabel?
    private var cellHeight:Float?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        webImageView = UIImageView(frame: CGRect(x: 0, y: 30, width: self.frame.width, height: 100))
        titleLabel = UILabel(frame: CGRect(x: 0, y: 5, width: self.frame.width, height: 21))
        titleLabel?.backgroundColor = UIColor.clear
        titleLabel?.textAlignment = .center
        titleLabel?.textColor = UIColor.purple
        titleLabel?.font = UIFont.italicSystemFont(ofSize: 17)
        dateLabel = UILabel(frame: CGRect(x: 0, y: 140, width: self.frame.width, height: 21))
        dateLabel?.textAlignment = .center
        self.contentView.addSubview(titleLabel!)
        self.contentView.addSubview(dateLabel!)
        self.contentView.addSubview(webImageView!)
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
