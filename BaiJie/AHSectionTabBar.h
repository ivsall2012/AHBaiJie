//
//  AHSectionTabBar.h
//  BaiJie
//
//  Created by Andy Hurricane on 3/31/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AHSectionTabBar;
@protocol AHSectionTabBarDelegate <NSObject>

@optional
-(void)sectionTabBar:(AHSectionTabBar *)sectionTabBar didSelectionTabBarTitle:(NSString *)title;

@end
@interface AHSectionTabBar : UIView
@property (nonatomic, weak) id<AHSectionTabBarDelegate> delegate;
-(void)addTabBarByTitle:(NSString *)title;
-(void)selectTabBarByTitle:(NSString *)title;
@end
