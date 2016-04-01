//
//  AHSectionTabBar.h
//  BaiJie
//
//  Created by Andy Hurricane on 3/31/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    AHSectionTabBarButtonTypeRecommend=99,
    AHSectionTabBarButtonTypeVideo,
    AHSectionTabBarButtonTypeVoice,
    AHSectionTabBarButtonTypeJoke,
    AHSectionTabBarButtonTypePicture
} AHSectionTabBarButtonType;

@class AHSectionTabBar;
@protocol AHSectionTabBarDelegate <NSObject>

@optional
-(void)sectionTabBar:(AHSectionTabBar *)sectionTabBar didSelectionButtonType:(AHSectionTabBarButtonType)type;

@end
@interface AHSectionTabBar : UIView
@property (nonatomic, weak) id<AHSectionTabBarDelegate> delegate;
-(void)selectButtonType:(AHSectionTabBarButtonType)type;
@end
