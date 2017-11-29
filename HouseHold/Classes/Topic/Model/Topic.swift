//
//  Topic.swift
//  HouseHold
//
//  Created by brant on 2017/11/28.
//  Copyright © 2017年 brant. All rights reserved.
//

import Foundation
import AVOSCloud

class Topic: AVObject, AVSubclassing {
    
//    @property (nonatomic, copy) NSString *title;
//    @property (nonatomic, copy) NSString *desc;
//    @property (nonatomic, strong) AVFile *cover;
//    @property (nonatomic, strong) NSNumber *likeCount;
    
    @objc dynamic var title: String?
    @objc dynamic var desc: String?
    @objc dynamic var cover: AVFile?
    @objc dynamic var likeCount: Int = 0
    
    static func parseClassName() -> String {
        return "Topic"
    }
}
