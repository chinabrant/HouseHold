//
//  Strategy.swift
//  HouseHold
//
//  Created by 吴述军 on 26/11/2017.
//  Copyright © 2017 brant. All rights reserved.
//

import Foundation
import AVOSCloud

class Strategy: AVObject, AVSubclassing  {
    
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
    
}
