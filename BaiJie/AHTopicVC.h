//
//  AHTopicVC.h
//  BaiJie
//
//  Created by Andy Hurricane on 4/2/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    AHTopicTypeAllKinds = 1,
    AHTopicTypePicture = 10,
    AHTopicTypeJoke = 29,
    AHTopicTypeVoice = 31,
    AHTopicTypeVideo = 41
} AHTopicType;
@interface AHTopicVC : UITableViewController
@property (nonatomic, assign) AHTopicType topicType;
@end
