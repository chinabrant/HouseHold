//
//  Strategy.swift
//  HouseHold
//
//  Created by 吴述军 on 26/11/2017.
//  Copyright © 2017 brant. All rights reserved.
//

import Foundation
import AVOSCloud

class Strategy: AVObject, AVSubclassing, NSCopying  {

    // 标题
    var title: String? {
        set {
            setObject(newValue, forKey: "title")
        }
        get {
            return self.object(forKey: "title") as? String
        }
    }
    
    // 一句话描述
    var subtitle: String? {
        set {
            setObject(newValue, forKey: "subtitle")
        }
        get {
            return self.object(forKey: "subtitle") as? String
        }
    }
    
    // 描述
    var desc: String? {
        set {
            setObject(newValue, forKey: "desc")
        }
        get {
            return self.object(forKey: "desc") as? String
        }
    }
    
    // 封面图
    var cover: AVFile? {
        set {
            setObject(newValue, forKey: "cover")
        }
        get {
            return self.object(forKey: "cover") as? AVFile
        }
    }
    
    var likeCount: Int = 0
    var user: AVUser? {
        set {
            setObject(newValue, forKey: "user")
        }
        get {
            return self.object(forKey: "user") as? AVUser
        }
    }
    
    var topic: Topic? {
        set {
            setObject(newValue, forKey: "topic")
        }
        get {
            return self.object(forKey: "topic") as? Topic
        }
    }
    
    
    static func parseClassName() -> String {
        return "Strategy"
    }
    
    func attributedDesc() -> NSAttributedString? {
        let desc = self.desc == nil ? "请点击输入描述" : self.desc!
        
        let attri = NSMutableAttributedString(string: desc)
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 8
        style.alignment = NSTextAlignment.justified
        attri.addAttribute(NSAttributedStringKey.paragraphStyle, value: style, range: NSMakeRange(0, attri.length))
        attri.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 15), range: NSMakeRange(0, attri.length))
        
        return attri
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let strategy = Strategy(objectId: self.objectId!)
//        topic.cover = self.cover
//        topic.title = self.title
//        topic.desc = self.desc
//        topic.isShow = self.isShow
        
        return strategy
    }
}
