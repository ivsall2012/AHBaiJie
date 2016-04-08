//
//  AHComment.h
//  BaiJie
//
//  Created by Andy Hurricane on 4/6/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AHUser;
@interface AHComment : NSObject
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *like_count;
@property (nonatomic, strong) AHUser *user;
@property (nonatomic,assign) CGFloat cellHeight;
@end
