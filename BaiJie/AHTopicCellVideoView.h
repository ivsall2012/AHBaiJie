//
//  AHTopicCellVideoView.h
//  BaiJie
//
//  Created by Andy Hurricane on 4/6/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AHTopic;

@interface AHTopicCellVideoView : UIView
@property (nonatomic, strong) AHTopic *topic;
+(instancetype)videoView;
@end
