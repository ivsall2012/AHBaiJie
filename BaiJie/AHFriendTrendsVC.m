//
//  AHFriendTrendsVC.m
//  BaiJie
//
//  Created by Andy Hurricane on 3/27/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import "AHFriendTrendsVC.h"
#import "UIBarButtonItem+Extension.h"
@interface AHFriendTrendsVC ()

@end

@implementation AHFriendTrendsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的关注";
    UIButton *recommentBtn = [[UIButton alloc]init];
    [recommentBtn setImage:[UIImage imageNamed:@"friendsRecommentIcon"] forState:UIControlStateNormal];
    [recommentBtn setImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] forState:UIControlStateHighlighted];
    recommentBtn.size = recommentBtn.currentImage.size;
    [recommentBtn addTarget:self action:@selector(clickRecommentBtn) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:recommentBtn];
}
-(void)clickRecommentBtn{
    AHLogFunc;
}
@end
