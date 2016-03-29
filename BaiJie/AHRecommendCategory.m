//
//  AHRecommendCategory.m
//  BaiJie
//
//  Created by Andy Hurricane on 3/28/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import "AHRecommendCategory.h"

@implementation AHRecommendCategory
-(NSMutableArray<AHRecommendUser *> *)users{
    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}
@end
