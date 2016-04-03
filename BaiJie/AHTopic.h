//
//  AHTopic.h
//  BaiJie
//
//  Created by Andy Hurricane on 4/1/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AHTopic : NSObject
@property (nonatomic,copy) NSString *text;
@property (nonatomic,copy) NSString *profile_image;
@property (nonatomic,copy) NSString *comment;
@property (nonatomic,copy) NSString *repost;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *cai;
@property (nonatomic,copy) NSString *ding;
@property (nonatomic,copy) NSString *created_at;

/**
 *  the following width and height are for images/videos
 */
@property (nonatomic,copy) NSString *width;
@property (nonatomic,copy) NSString *height;






@property (nonatomic,assign) CGFloat cellHeight;
@end
