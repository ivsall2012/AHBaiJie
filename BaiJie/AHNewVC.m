//
//  AHNewVC.m
//  BaiJie
//
//  Created by Andy Hurricane on 3/27/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import "AHNewVC.h"
#import "UIBarButtonItem+Extension.h"
@interface AHNewVC ()

@end

@implementation AHNewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = AHGlobelViewColor;
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(clickTag)];
}
-(void)clickTag{
    AHLogFunc;
}

@end
