//
//  TextTableViewCell.swift
//  MyLaugh
//
//  Created by vip on 17/1/14.
//  Copyright © 2017年 jaki. All rights reserved.
//

import UIKit

class TextTableViewCell: UITableViewCell {
    private var titleLabel:UILabel?
    private var contentLabel:UILabel?
    private var dateLabel:UILabel?
    var title:String?{
        willSet{
            titleLabel?.text = newValue
        }
    }
    var content:String?{
        willSet{
            contentLabel?.text = newValue
        }
    }
    var date:String?{
        willSet{
            dateLabel?.text = newValue
        }
    }
    func getHeight() -> Float {
        //计算文字高度
        let dic = [NSFontAttributeName:contentLabel?.font]
        let size = contentLabel!.text!.boundingRect(with: CGSize(width: self.frame.width, height: CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin),attributes:dic, context: nil).size
        contentLabel?.frame = CGRect(x: 0, y: 30, width: self.frame.width, height: size.height)
        dateLabel?.frame = CGRect(x: 0, y: 35+size.height, width: self.frame.width, height: 21)
        return 30+Float(size.height)+10+21+5
    }
    func setContentLabelHeight(height:Float)  {
        contentLabel?.frame = CGRect(x: 0, y: 30, width: self.frame.size.width, height: CGFloat(height))
        dateLabel?.frame = CGRect(x: 0, y: CGFloat(35+height), width: self.frame.size.width, height: 21)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        titleLabel = UILabel(frame: CGRect(x: 0, y: 5, width: self.frame.size.width, height: 21))
        titleLabel?.backgroundColor = UIColor.clear
        titleLabel?.textAlignment = .center
        titleLabel?.textColor = UIColor.purple
        titleLabel?.font = UIFont.systemFont(ofSize: 17)
        contentLabel = UILabel(frame: CGRect(x: 0, y: 30, width: self.frame.size.width, height: 21))
        contentLabel?.backgroundColor = UIColor.clear
        contentLabel?.numberOfLines = 0
        dateLabel = UILabel(frame: CGRect(x: 0, y: 30, width: self.frame.size.width, height: 21))
        dateLabel?.textAlignment = .right
        self.contentView.addSubview(titleLabel!)
        self.contentView.addSubview(contentLabel!)
        self.contentView.addSubview(dateLabel!)
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
