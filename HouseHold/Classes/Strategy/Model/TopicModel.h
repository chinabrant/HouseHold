//
//  TopicModel.h
//  HouseHold
//
//  Created by 吴述军 on 24/10/2017.
//  Copyright © 2017 brant. All rights reserved.
//

#import <AVOSCloud/AVOSCloud.h>

@interface TopicModel : AVObject <AVSubclassing>
    
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, strong) AVFile *cover;
@property (nonatomic, strong) NSNumber *likeCount;

@end
