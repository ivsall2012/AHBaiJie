//
//  AHSectionTabBar.m
//  BaiJie
//
//  Created by Andy Hurricane on 3/31/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import "AHSectionTabBar.h"
#define AHSectionTabBarFont [UIFont systemFontOfSize:16]

@interface AHSectionTabBar()
@property (nonatomic, strong) UIButton *currentTabBar;
@property (nonatomic, weak) UIView *indicator;
@property (nonatomic, strong) NSMutableArray *tabBarArray;
@end
@implementation AHSectionTabBar
-(NSMutableArray *)tabBarArray{
    if (!_tabBarArray) {
        _tabBarArray = [NSMutableArray array];
    }
    return _tabBarArray;
}
-(UIView *)indicator{
    if (!_indicator) {
        UIView *indicator = [[UIView alloc]init];
        indicator.height =2;
        indicator.backgroundColor = [UIColor redColor];
        [self addSubview:indicator];
        self.indicator = indicator;
        // set it's width/x/y later since the width is based on its corresponding self/buttons
    }
    return _indicator;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    }
    return self;
}
-(void)addTabBarByTitle:(NSString *)title{
    UIButton *btn =[[UIButton alloc]init];
    btn.titleLabel.font = AHSectionTabBarFont;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
    [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:btn];
    [self.tabBarArray addObject:btn];
}
-(void)clickButton:(UIButton *)button{
    self.currentTabBar.enabled = YES;
    button.enabled = NO;
    self.currentTabBar = button;
    
    // now we know which button being clicked on, indicator's width/x/y can be certain
    if (_indicator == nil) {
        // indicator is lazy loading, no animation for the first time
        [self indicatorSetup:button];
    }else{
        [UIView animateWithDuration:0.25 animations:^{
            [self indicatorSetup:button];
        }];
    }
    if ([self.delegate respondsToSelector:@selector(sectionTabBar:didSelectionTabBarTitle:)]) {
        [self.delegate sectionTabBar:self didSelectionTabBarTitle:button.titleLabel.text];
    }
}
-(void)selectTabBarByTitle:(NSString *)title{
    UIButton *selectedBtn = nil;
    for (UIButton *btn in self.tabBarArray) {
        if ([btn.titleLabel.text isEqualToString:title]) {
            selectedBtn = btn;
            break;
        }
    }
    [self clickButton:selectedBtn];
    
}

-(void)indicatorSetup:(UIButton *)button{
    self.indicator.width = button.titleLabel.width;
    self.indicator.centerX = button.centerX; // DO NOT =button.titleLabel.centerX
    self.indicator.Y = self.height - self.indicator.height;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat width = self.width/self.tabBarArray.count;
    CGFloat height = self.height;
    for (int i=0; i<self.tabBarArray.count; i++) {
        UIButton *btn = self.tabBarArray[i];
        btn.height = height;
        btn.width = width;
        btn.X = i * width;
        btn.Y = 0;
    }
}
@end
