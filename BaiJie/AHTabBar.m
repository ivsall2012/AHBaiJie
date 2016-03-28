//
//  AHTabBar.m
//  BaiJie
//
//  Created by Andy Hurricane on 3/27/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import "AHTabBar.h"

@interface AHTabBar()
@property (nonatomic, weak) UIButton *publishButton;
@end

@implementation AHTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *publishButton = [[UIButton alloc]init];
        [publishButton setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [publishButton addTarget:self action:@selector(tabBarDidClickPublishButton) forControlEvents:UIControlEventTouchUpInside];
        publishButton.size = publishButton.currentImage.size;
        [self addSubview:publishButton];
        self.publishButton = publishButton;
        
        self.backgroundImage = [UIImage imageNamed:@"tabbar-light"];
    }
    return self;
}
-(void)tabBarDidClickPublishButton{
    AHLogFunc;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    
    
    NSInteger index = 0;
    CGFloat buttonW = self.width/5;
    CGFloat buttonH = self.height;
    CGFloat buttonY = 0;
    
    
    for (UIView *button in self.subviews) {
        if (![button isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            continue;
        }
        CGFloat buttonX = buttonW * (index>1?index+1:index);
        button.X = buttonX;
        button.Y = buttonY;
        button.width = buttonW;
        button.height = buttonH;
        index++;
    }
    self.publishButton.center = CGPointMake(self.width*0.5, self.height*0.5);

}
@end
