//
//  AHTabBarVC.m
//  BaiJie
//
//  Created by Andy Hurricane on 3/27/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import "AHTabBarVC.h"

@implementation AHTabBarVC
+(void)initialize{
    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    [barItem setTitleTextAttributes:@{NSFontAttributeName:AHTabBarFont} forState:UIControlStateNormal];
    [barItem setTitleTextAttributes:@{NSFontAttributeName:AHTabBarFont} forState:UIControlStateSelected];
    [barItem setTitleTextAttributes:@{NSForegroundColorAttributeName:AHColor(140, 132, 128)} forState:UIControlStateNormal];
    [barItem setTitleTextAttributes:@{NSForegroundColorAttributeName:AHColor(81, 81, 81)} forState:UIControlStateSelected];
}

-(void)viewDidLoad{
    [self setupVCs];
}
-(void)setupVCs{
    UIViewController *vc1 = [[UIViewController alloc]init];
    vc1.tabBarItem.title = @"精华";
    vc1.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    vc1.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_essence_click_icon"];
    vc1.view.backgroundColor = AHRandomColor;
    [vc1.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:AHColor(140, 132, 128)} forState:UIControlStateNormal];
    [vc1.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:AHColor(81, 81, 81)} forState:UIControlStateSelected];
                                            
    UIViewController *vc2 = [[UIViewController alloc]init];
    vc2.tabBarItem.title = @"新帖";
    vc2.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    vc2.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_new_click_icon"];
    vc2.view.backgroundColor = AHRandomColor;
    [vc2.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:AHColor(140, 132, 128)} forState:UIControlStateNormal];
    [vc2.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:AHColor(81, 81, 81)} forState:UIControlStateSelected];
    
    UIViewController *vc3 = [[UIViewController alloc]init];
    vc3.tabBarItem.title = @"关注";
    vc3.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    vc3.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_friendTrends_click_icon"];
    vc3.view.backgroundColor = AHRandomColor;
    [vc3.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:AHColor(140, 132, 128)} forState:UIControlStateNormal];
    [vc3.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:AHColor(81, 81, 81)} forState:UIControlStateSelected];
    
    UIViewController *vc4 = [[UIViewController alloc]init];
    vc4.tabBarItem.title = @"我的";
    vc4.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    vc4.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_me_click_icon"];
    vc4.view.backgroundColor = AHRandomColor;
    [vc4.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:AHColor(140, 132, 128)} forState:UIControlStateNormal];
    [vc4.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:AHColor(81, 81, 81)} forState:UIControlStateSelected];
    
    self.viewControllers = @[vc1,vc2,vc3,vc4];
}
@end
