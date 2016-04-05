//
//  AHPublishView.m
//  BaiJie
//
//  Created by Andy Hurricane on 4/4/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import "AHPublishView.h"
#import "AHStackButton.h"
#import <POP.h>
#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height

@interface AHPublishView()
@property (nonatomic, weak) UIButton *calcelButton;
@property (nonatomic, strong) NSMutableArray *buttonArray;
@property (nonatomic, weak) UIImageView *sloganView;
@end
@implementation AHPublishView
-(NSArray *)buttonArray{
    if (!_buttonArray) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
        [self setupCancelButton];
        [self setupButtons];
    }
    return self;
}
-(void)setupCancelButton{
    UIButton *cancelButton = [[UIButton alloc]init];
    [cancelButton setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
    [cancelButton setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
    [cancelButton addTarget:self action:@selector(cancelPublish) forControlEvents:UIControlEventTouchUpInside];
    cancelButton.width = screenW;
    cancelButton.height = 49;
    cancelButton.X = 0;
    cancelButton.Y = screenH - cancelButton.height;
    [self addSubview:cancelButton];
    self.calcelButton = cancelButton;
}
-(void)setupButtons{
    CGFloat margin = 10;
    
    NSArray *images = @[@"publish-video",@"publish-picture",@"publish-text",@"publish-audio",@"publish-review",@"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    CGFloat buttonWidth = 72;
    CGFloat buttonHeight = buttonWidth + 30;
    CGFloat buttonStartY = screenH*0.3;
    CGFloat padding = (screenW- 2*margin - 3*buttonWidth)/2;
    for (int i=0; i< images.count; i++) {
        AHStackButton *button = [[AHStackButton alloc]init];
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        NSString *image = images[i];
        [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:button];
        [self.buttonArray addObject:button];
        
//        button.width = buttonWidth;
//        button.height = buttonHeight;
//        button.X = margin + (i%3) * (buttonWidth+padding);
//        button.Y = buttonStartY + (i/3)*buttonHeight;
        
        CGFloat buttonX = margin + (i%3) * (buttonWidth+padding);
        CGFloat endY = buttonStartY + (i/3)*buttonHeight;
        CGFloat startY = endY - screenH;
        POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        springAnimation.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, startY, buttonWidth, buttonHeight)];
        springAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, endY, buttonWidth, buttonHeight)];
        springAnimation.springBounciness = 7;
        springAnimation.springSpeed = 20;
        springAnimation.beginTime = CACurrentMediaTime() + 0.05*(images.count - 1 - i);
        [button pop_addAnimation:springAnimation forKey:nil];
        
    }
    
    UIImageView *slogan = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_slogan"]];
    [self addSubview:slogan];
    self.sloganView = slogan;
    
    CGFloat endY = screenH*0.2;
    CGFloat centerX = screenW*0.5;
    CGFloat startY = endY - screenH;
    
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    springAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerX, startY)];
    springAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, endY)];
    springAnimation.springBounciness = 7;
    springAnimation.springSpeed = 20;
    springAnimation.beginTime = CACurrentMediaTime() + 0.05*images.count;
    [slogan pop_addAnimation:springAnimation forKey:nil];
    
    
}
-(void)clickButton:(AHStackButton *)buttom{
    [self cancelWithCompletion:^{
        AHLog(@"%@",buttom.titleLabel.text);
    }];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self cancelWithCompletion:nil];
}
-(void)cancelWithCompletion:(void(^)())completionBlock{
    self.userInteractionEnabled = NO;
    
    
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewAlpha];
    animation.toValue = @(0);
    animation.beginTime = CACurrentMediaTime() + 0.05*self.buttonArray.count;
    [self pop_addAnimation:animation forKey:nil];
    
    for (int i=0; i <self.buttonArray.count; i++) {
        AHStackButton *button = self.buttonArray[i];
        CGFloat endCenterY = CGRectGetMaxY(self.frame) + 72 + 20;
        POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
        animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(button.centerX, button.centerY)];
        animation.toValue = [NSValue valueWithCGPoint:CGPointMake(button.centerX, endCenterY)];
        animation.springBounciness = 5;
        animation.springSpeed = 20;
        animation.beginTime = CACurrentMediaTime() + 0.01*i;
        [button pop_addAnimation:animation forKey:nil];
        if (i == self.buttonArray.count-1) {
            [animation setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
                [self removeFromSuperview];
                _window.hidden = YES;
                _window = nil;
                !completionBlock?:completionBlock();
                
            }];
        }
    }
    
//    CGFloat endCenterY = self.sloganView.centerY + screenH;
//    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
//    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.sloganView.centerX, self.sloganView.centerY)];
//    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.sloganView.centerX, endCenterY)];
//    animation.springBounciness = 10;
//    animation.springSpeed = 20;
//    animation.beginTime = CACurrentMediaTime() + 0.05*self.buttonArray.count;
//    [self.sloganView pop_addAnimation:animation forKey:nil];
//    [animation setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
//        [self removeFromSuperview];
//        _window.hidden = YES;
//        _window = nil;
//        !completionBlock?:completionBlock();
//        
//    }];

    
}
-(void)cancelPublish{
    [self cancelWithCompletion:nil];
}

static UIWindow *_window;
+(void)show{
    _window = [[UIWindow alloc]init];
    _window.frame = [UIScreen mainScreen].bounds;
    _window.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
    _window.hidden = NO;
    AHPublishView *publishView = [[AHPublishView alloc]init];
    publishView.frame = _window.bounds;
    [_window addSubview:publishView];
}
@end
