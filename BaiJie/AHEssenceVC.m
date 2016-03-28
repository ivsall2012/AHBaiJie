//
//  AHEssenceVC.m
//  BaiJie
//
//  Created by Andy Hurricane on 3/27/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import "AHEssenceVC.h"

@interface AHEssenceVC ()

@end

@implementation AHEssenceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    UIButton *tagBtn = [[UIButton alloc]init];
    [tagBtn setImage:[UIImage imageNamed:@"MainTagSubIcon"] forState:UIControlStateNormal];
    [tagBtn setImage:[UIImage imageNamed:@"MainTagSubIconClick"] forState:UIControlStateHighlighted];
    tagBtn.size = tagBtn.currentImage.size;
    [tagBtn addTarget:self action:@selector(clickTag) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:tagBtn];
}
-(void)clickTag{
    AHLogFunc;
}

@end
