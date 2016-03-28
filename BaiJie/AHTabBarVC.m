//
//  AHTabBarVC.m
//  BaiJie
//
//  Created by Andy Hurricane on 3/27/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import "AHTabBarVC.h"
#import "AHEssenceVC.h"
#import "AHNewVC.h"
#import "AHFriendTrendsVC.h"
#import "AHMeVC.h"
#import "AHTabBar.h"

@implementation AHTabBarVC
+(void)initialize{
    UITabBarItem *barItem = [UITabBarItem appearance];
    [barItem setTitleTextAttributes:@{NSForegroundColorAttributeName:AHColor(140, 132, 128)} forState:UIControlStateNormal];
    [barItem setTitleTextAttributes:@{NSForegroundColorAttributeName:AHColor(81, 81, 81)} forState:UIControlStateSelected];
    [barItem setTitleTextAttributes:@{NSFontAttributeName:AHTabBarFont} forState:UIControlStateNormal];
    
}

-(void)viewDidLoad{
    [self setupVCs];
}
-(void)setupVCs{
    AHEssenceVC *vc1 = [[AHEssenceVC alloc]init];
    [self createVC:vc1 title:@"精华" iamge:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    AHNewVC *vc2 = [[AHNewVC alloc]init];
    [self createVC:vc2 title:@"新帖" iamge:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    AHFriendTrendsVC *vc3 = [[AHFriendTrendsVC alloc]init];
    [self createVC:vc3 title:@"关注" iamge:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    
    AHMeVC *vc4 = [[AHMeVC alloc]init];
    [self createVC:vc4 title:@"我的" iamge:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
    
    AHTabBar *tabBar = [[AHTabBar alloc]init];
    [self setValue:tabBar forKey:@"tabBar"];
}
-(void)createVC:(UIViewController *)vc title:(NSString *)title iamge:(NSString *)image selectedImage:(NSString *)selectedImage{
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    vc.view.backgroundColor = AHRandomColor;
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    [self addChildViewController:nav];
}
@end
