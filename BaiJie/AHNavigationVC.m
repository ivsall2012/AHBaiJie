//
//  AHNavigationVC.m
//  BaiJie
//
//  Created by Andy Hurricane on 3/27/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import "AHNavigationVC.h"

@implementation AHNavigationVC
+(void)initialize{
    UINavigationBar *navItem = [UINavigationBar appearance];
    [navItem setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:0];
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    
    [super pushViewController:viewController animated:YES];
}
@end
