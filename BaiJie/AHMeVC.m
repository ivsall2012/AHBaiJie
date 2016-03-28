//
//  AHMeVC.m
//  BaiJie
//
//  Created by Andy Hurricane on 3/27/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import "AHMeVC.h"

@interface AHMeVC ()

@end

@implementation AHMeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的";
    UIButton *settingBtn = [[UIButton alloc]init];
    [settingBtn setImage:[UIImage imageNamed:@"mine-setting-icon"] forState:UIControlStateNormal];
    [settingBtn setImage:[UIImage imageNamed:@"mine-setting-icon-click"] forState:UIControlStateHighlighted];
    settingBtn.size = settingBtn.currentImage.size;
    [settingBtn addTarget:self action:@selector(clickSettingBtn) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *skinBtn = [[UIButton alloc]init];
    [skinBtn setImage:[UIImage imageNamed:@"mine-moon-icon"] forState:UIControlStateNormal];
    [skinBtn setImage:[UIImage imageNamed:@"mine-moon-icon-click"] forState:UIControlStateHighlighted];
    skinBtn.size = skinBtn.currentImage.size;
    [skinBtn addTarget:self action:@selector(clickSkinBtn) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItems = @[
                                               [[UIBarButtonItem alloc]initWithCustomView:settingBtn],
                                               [[UIBarButtonItem alloc]initWithCustomView:skinBtn]
    
                                               ];
}
-(void)clickSettingBtn{
    AHLogFunc;
}
-(void)clickSkinBtn{
    AHLogFunc;
}
@end
