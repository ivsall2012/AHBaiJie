//
//  AHRecommendUser.h
//  BaiJie
//
//  Created by Andy Hurricane on 3/28/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AHRecommendUser : NSObject
@property (nonatomic,assign) NSInteger uid;
@property (nonatomic,copy) NSString *screen_name;
@property (nonatomic,copy) NSString *introduction;
@property (nonatomic,copy) NSString *tiezi_count;
@property (nonatomic,copy) NSString *header;
@property (nonatomic,copy) NSString *gender;
@property (nonatomic,copy) NSString *is_follow;
@property (nonatomic,copy) NSString *fans_count;
@end
