//
//  AHWindow.m
//  LocalFun
//
//  Created by Andy Hurricane on 5/6/17.
//  Copyright © 2017 LocalFunApp. All rights reserved.
//

#import "AHWindow.h"

@interface AHWindow() <UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIView *touchIndicator;
@property (nonatomic, strong) UITapGestureRecognizer *tapGes;
@end

@implementation AHWindow

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        _tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandler:)];
        _tapGes.delegate = self;
        [self addGestureRecognizer:_tapGes];
        
        _touchIndicator = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        _touchIndicator.backgroundColor = [UIColor grayColor];
        _touchIndicator.layer.masksToBounds = YES;
        _touchIndicator.layer.cornerRadius = 25.0;
        _touchIndicator.alpha = 0.5;
        _touchIndicator.userInteractionEnabled = NO;
        [self addSubview:_touchIndicator];
    }
    return self;
}
-(void)tapHandler:(UITapGestureRecognizer *)tapGes {
    
}
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    CGPoint pt = [touch locationInView:self];
    [self handleTapAt:pt];
    return NO;
}
-(void)handleTapAt:(CGPoint)point{
    [self bringSubviewToFront:self.touchIndicator];
    self.touchIndicator.center = point;
    self.touchIndicator.alpha = 1.0;
    [UIView animateWithDuration:0.25 animations:^{
        self.touchIndicator.transform = CGAffineTransformMakeScale(1.3, 1.3);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25 animations:^{
            self.touchIndicator.transform = CGAffineTransformIdentity;
            self.touchIndicator.alpha = 0.5;
        } completion:^(BOOL finished) {
            
        }];
    }];
}
@end







