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
@property (nonatomic, strong) UIButton *currentButton;
@property (nonatomic, weak) UIView *bottomIndicator;
@property (nonatomic, strong) NSMutableArray *buttonArray;
@end
@implementation AHSectionTabBar
-(NSMutableArray *)buttonArray{
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}
-(UIView *)bottomIndicator{
    if (!_bottomIndicator) {
        UIView *indicator = [[UIView alloc]init];
        indicator.height =2;
        indicator.backgroundColor = [UIColor redColor];
        [self addSubview:indicator];
        self.bottomIndicator = indicator;
        // set it's width/x/y later since the width is based on its corresponding self/buttons
    }
    return _bottomIndicator;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    }
    return self;
}
-(void)initButtons{
    [self createTabButtonWithTitle:@"推荐" buttonType:AHSectionTabBarButtonTypeRecommend];
    [self createTabButtonWithTitle:@"视频" buttonType:AHSectionTabBarButtonTypeVideo];
    [self createTabButtonWithTitle:@"图片" buttonType:AHSectionTabBarButtonTypePicture];
    [self createTabButtonWithTitle:@"段子" buttonType:AHSectionTabBarButtonTypeJoke];
    [self createTabButtonWithTitle:@"声音" buttonType:AHSectionTabBarButtonTypeVoice];
}
-(void)createTabButtonWithTitle:(NSString *)title buttonType:(AHSectionTabBarButtonType)type{
    UIButton *btn =[[UIButton alloc]init];
    btn.titleLabel.font = AHSectionTabBarFont;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
    btn.tag= type;
    [btn addTarget:self action:@selector(sectionTabBarDidSelectionButton:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:btn];
    [self.buttonArray addObject:btn];
    
}
// this is public, an interface for outsider to select buttons.
-(void)selectButtonType:(AHSectionTabBarButtonType)type{
    UIButton *btn = [self viewWithTag:type];
    [self sectionTabBarDidSelectionButton:btn];
}
-(void)sectionTabBarDidSelectionButton:(UIButton *)button{
    self.currentButton.enabled = YES;
    button.enabled = NO;
    self.currentButton = button;
    
    // now we know which button being clicked on, indicator's width/x/y can be certain
    if (_bottomIndicator == nil) {
        // bottomIndicator is lazy loading, no animation for the first time
        [self indicatorSetup:button];
    }else{
        [UIView animateWithDuration:0.25 animations:^{
            [self indicatorSetup:button];
        }];
    }
    if ([self.delegate respondsToSelector:@selector(sectionTabBar:didSelectionButtonType:)]) {
        [self. delegate sectionTabBar:self didSelectionButtonType:(AHSectionTabBarButtonType)button.tag];
    }
    
}
-(void)indicatorSetup:(UIButton *)button{
    self.bottomIndicator.width = button.titleLabel.width;
    self.bottomIndicator.centerX = button.centerX; // DO NOT button.titleLabel.centerX
    self.bottomIndicator.Y = self.height - self.bottomIndicator.height;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat width = self.width/self.buttonArray.count;
    CGFloat height = self.height;
    for (int i=0; i<self.buttonArray.count; i++) {
        UIButton *btn = self.buttonArray[i];
        btn.height = height;
        btn.width = width;
        btn.X = i * width;
        btn.Y = 0;
    }
}
@end
