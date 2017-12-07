//
//  StrategyItem.swift
//  HouseHold
//
//  Created by 吴述军 on 01/12/2017.
//  Copyright © 2017 brant. All rights reserved.
//

import Foundation
import AVOSCloud

class StrategyItem: AVObject, AVSubclassing {
    
    // 标题
    var title: String? {
        set {
            setObject(newValue, forKey: "title")
        }
        get {
            return self.object(forKey: "title") as? String
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
    
    // 淘宝商品id
    var tbid: String? {
        set {
            setObject(newValue, forKey: "tbid")
        }
        get {
            return self.object(forKey: "tbid") as? String
        }
    }
    
    var strategy: Strategy? {
        set {
            setObject(newValue, forKey: "strategy")
        }
        get {
            return self.object(forKey: "strategy") as? Strategy
        }
    }
    
    var user: AVUser? {
        set {
            setObject(newValue, forKey: "user")
        }
        get {
            return self.object(forKey: "user") as? AVUser
        }
    }
    
    var price: Double? {
        set {
            setObject(newValue, forKey: "price")
        }
        get {
            return self.object(forKey: "price") as? Double
        }
    }
    
    var img: AVFile? {
        set {
            setObject(newValue, forKey: "img")
        }
        get {
            return self.object(forKey: "img") as? AVFile
        }
    }
    
    var cellHeight: CGFloat = 0
    
    static func parseClassName() -> String {
        return "StrategyItem"
    }
    
    func attributedDesc() -> NSAttributedString? {
        guard let desc = self.desc else {
            return nil
        }
        
        let attri = NSMutableAttributedString(string: desc)
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 8
        attri.addAttribute(NSAttributedStringKey.paragraphStyle, value: style, range: NSMakeRange(0, attri.length))
        attri.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 15), range: NSMakeRange(0, attri.length))
        
        return attri
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let item = StrategyItem(objectId: self.objectId!)
//        item.img = self.img
//        item.title = self.title
//        item.desc = self.desc
//        item.tbid = self.tbid
//        item.price = self.price
//        item.topic = self.topic
        
        return item
    }
}
