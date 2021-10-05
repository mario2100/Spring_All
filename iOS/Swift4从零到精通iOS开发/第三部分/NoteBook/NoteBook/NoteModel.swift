//
//  NoteModel.swift
//  NoteBook
//
//  Created by vip on 16/11/12.
//  Copyright © 2016年 jaki. All rights reserved.
//

import UIKit

class NoteModel: NSObject {
    var time:String?
    var title:String?
    var body:String?
    var group:String?
    var noteId:Int?
    
    func toDictionary() -> Dictionary<String,Any> {
        var dic:[String:Any] = ["time":time!,"title":title!,"body":body!,"ownGroup":group!]
        if let id = noteId {
            dic["noteId"] = id
        }
        return dic
    }
}
