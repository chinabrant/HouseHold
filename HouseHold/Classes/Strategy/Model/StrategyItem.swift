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
    
    var price: Double? = 0.0
    
    var img: AVFile? {
        set {
            setObject(newValue, forKey: "img")
        }
        get {
            return self.object(forKey: "img") as? AVFile
        }
    }
    
    static func parseClassName() -> String {
        return "StrategyItem"
    }
}
