//
//  AHRecommendCategory.h
//  BaiJie
//
//  Created by Andy Hurricane on 3/28/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AHRecommendCategory : NSObject
@property (nonatomic, strong) NSString *id;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,assign) NSInteger count;
@end
