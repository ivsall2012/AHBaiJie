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
    
    self.imageView.centerX = self.width*0.5;
    self.imageView.Y = 0;
    self.imageView.width = self.currentImage.size.width;
    self.imageView.height = self.currentImage.size.height;
    
    
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.imageView.height;
    self.titleLabel.X = 0;
    self.titleLabel.Y = CGRectGetMaxY(self.imageView.frame);
}

@end
