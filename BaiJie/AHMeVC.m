//
//  AHMeVC.m
//  BaiJie
//
//  Created by Andy Hurricane on 3/27/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import "AHMeVC.h"
#import "UIBarButtonItem+Extension.h"
#import "TestVC_one.h"
@interface AHMeVC ()

@end

@implementation AHMeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的";
    UIBarButtonItem *settingBtn = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(clickSettingBtn)];
    
    UIBarButtonItem *skinBtn = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(clickSkinBtn)];
    
    self.navigationItem.rightBarButtonItems = @[settingBtn,skinBtn];
}
-(void)clickSettingBtn{
    [self.navigationController pushViewController:[[TestVC_one alloc]init] animated:YES];
}
-(void)clickSkinBtn{
    AHLogFunc;
}
@end
