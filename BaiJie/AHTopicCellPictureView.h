//
//  AHTopicCellPictureView.h
//  BaiJie
//
//  Created by Andy Hurricane on 4/3/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AHTopic;
@interface AHTopicCellPictureView : UIView
@property (nonatomic, strong) AHTopic *topic;
+(instancetype)pictureView;
@end
