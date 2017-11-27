//
//  StrategyModel.h
//  HouseHold
//
//  Created by 吴述军 on 24/10/2017.
//  Copyright © 2017 brant. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>
#import "TopicModel.h"

@interface StrategyModel : AVObject <AVSubclassing>
    
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, strong) AVFile *cover;
@property (nonatomic, strong) NSNumber *likeCount;
@property (nonatomic, strong) AVUser *user;
@property (nonatomic, strong) TopicModel *topic;

@end
