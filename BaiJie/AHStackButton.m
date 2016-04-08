//
//  AHStackButton.m
//  BaiJie
//
//  Created by Andy Hurricane on 3/30/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import "AHStackButton.h"

@implementation AHStackButton


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initTitleLabel];
    }
    return self;
}
-(void)awakeFromNib{
    [self initTitleLabel];
}
-(void)initTitleLabel{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}
-(void)setTitle:(NSString *)title forState:(UIControlState)state{
    [super setTitle:title forState:state];
    [self setNeedsLayout];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.X = self.imageView.Y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;
    
    
    self.titleLabel.width = self.imageView.width;
    self.titleLabel.height = self.height - self.imageView.height;
    self.titleLabel.X = self.imageView.X;
    self.titleLabel.Y = CGRectGetMaxY(self.imageView.frame);
}

@end
