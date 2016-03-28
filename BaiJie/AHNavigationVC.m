//
//  AHNavigationVC.m
//  BaiJie
//
//  Created by Andy Hurricane on 3/27/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import "AHNavigationVC.h"
#import "UIBarButtonItem+Extension.h"

@implementation AHNavigationVC
+(void)initialize{
    UINavigationBar *navItem = [UINavigationBar appearance];
    [navItem setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:0];
 
}
-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = AHGlobelViewColor;  
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count >0) { // for left and right custome navigation side buttons
        // this doesn't include the first view and the view popped in(model)
        UIBarButtonItem *backButton = [UIBarButtonItem itemWithImage:@"navigationButtonReturn" highImage:@"navigationButtonReturnClick" target:self action:@selector(clickBackButton) settingBlock:^(UIButton *button) {
            [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
            
        }];
        viewController.navigationItem.leftBarButtonItem = backButton;
        
        UIBarButtonItem *forwardButton = [UIBarButtonItem itemWithImage:@"navigationButtonReturn" highImage:@"navigationButtonReturnClick" target:self action:@selector(clickForwardButton) settingBlock:^(UIButton *button) {
            [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
            
        }];
        viewController.navigationItem.rightBarButtonItem = forwardButton;
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:YES];
}
-(void)clickBackButton{
    // DO NOT USE self.navigationVC, here's in a navVC!!
//    [self.navigationController popViewControllerAnimated:YES];
    [self popViewControllerAnimated:YES];
}
-(void)clickForwardButton{
    AHLogFunc;
//    [self.navigationController popToRootViewControllerAnimated:YES];
    [self popToRootViewControllerAnimated:YES];
}
@end
