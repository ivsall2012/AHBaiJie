//
//  AHPublishView.m
//  BaiJie
//
//  Created by Andy Hurricane on 4/4/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import "AHPublishView.h"
#import "AHStackButton.h"

#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height

@interface AHPublishView()
@property (nonatomic, weak) UIButton *calcelButton;
@property (nonatomic, strong) NSMutableArray *buttonArray;
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
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
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
        button.width = buttonWidth;
        button.height = buttonHeight;
        button.X = margin + (i%3) * (buttonWidth+padding);
        button.Y = buttonStartY + (i/3)*buttonHeight;
        
        [self addSubview:button];
    }
    
    UIImageView *slogan = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_slogan"]];
    CGFloat startY = screenH*0.2;
    slogan.centerX = screenW*0.5;
    slogan.Y = startY;
    [self addSubview:slogan];
    
    
}
-(void)clickButton:(AHStackButton *)buttom{
    
}
-(void)cancelPublish{
    [self removeFromSuperview];
    _window.hidden = YES;
    _window = nil;
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
