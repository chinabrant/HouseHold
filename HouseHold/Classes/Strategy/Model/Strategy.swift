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
    
//    @property (nonatomic, copy) NSString *title;
//    @property (nonatomic, copy) NSString *subtitle;
//    @property (nonatomic, copy) NSString *desc;
//    @property (nonatomic, strong) AVFile *cover;
//    @property (nonatomic, strong) NSNumber *likeCount;
//    @property (nonatomic, strong) AVUser *user;
//    @property (nonatomic, strong) TopicModel *topic;

    @objc dynamic var title: String?
    @objc dynamic var subtitle: String?
    @objc dynamic var desc: String?
    @objc dynamic var cover: AVFile?
    @objc dynamic var likeCount: Int = 0
    @objc dynamic var user: AVUser?
    @objc dynamic var topic: Topic?
    
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
