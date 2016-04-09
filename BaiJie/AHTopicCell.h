//
//  AHTopicCell.h
//  BaiJie
//
//  Created by Andy Hurricane on 4/2/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AHTopic.h"
@interface AHTopicCell : UITableViewCell
@property (nonatomic, strong) AHTopic *topic;
+(instancetype)cell;
@end
