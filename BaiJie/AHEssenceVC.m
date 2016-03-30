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
@interface AHEssenceVC ()

@end

@implementation AHEssenceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(clickTag)];
}
-(void)clickTag{
    AHRecommendSubsribeVC *recommendSubcribeVC = [[AHRecommendSubsribeVC alloc]init];
    [self.navigationController pushViewController:recommendSubcribeVC animated:YES];
}

@end
