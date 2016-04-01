//
//  AHEssenceVC.m
//  BaiJie
//
//  Created by Andy Hurricane on 3/27/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import "AHEssenceVC.h"
#import "UIBarButtonItem+Extension.h"
#import "AHRecommendSubsribeVC.h"
#import "AHSectionTabBar.h"
@interface AHEssenceVC ()<AHSectionTabBarDelegate>
@property (nonatomic, weak) AHSectionTabBar *sectionTabBar;
@end

@implementation AHEssenceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(clickTag)];
    AHSectionTabBar *sectionTabBar = [[AHSectionTabBar alloc]init];
    sectionTabBar.width = self.view.width;
    sectionTabBar.height = 35;
    sectionTabBar.X = 0;
    sectionTabBar.Y = 64;
    sectionTabBar.delegate = self;
    [self.view addSubview:sectionTabBar];
    self.sectionTabBar = sectionTabBar;
    
}

// this method will be called twice -- the delegate twice as well, button couldnt be empty, need more code for filtering...
//-(void)viewDidLayoutSubviews{
//    [super viewDidLayoutSubviews];
//    [self.sectionTabBar selectButtonType:AHSectionTabBarButtonTypeRecommend];
//}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.sectionTabBar selectButtonType:AHSectionTabBarButtonTypeRecommend];
}
-(void)clickTag{
    AHRecommendSubsribeVC *recommendSubcribeVC = [[AHRecommendSubsribeVC alloc]init];
    [self.navigationController pushViewController:recommendSubcribeVC animated:YES];
}
-(void)sectionTabBar:(AHSectionTabBar *)sectionTabBar didSelectionButtonType:(AHSectionTabBarButtonType)type{
    AHLogFunc;
}
@end
