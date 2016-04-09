//
//  AHProgress.m
//  BaiJie
//
//  Created by Andy Hurricane on 4/3/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import "AHProgress.h"

@implementation AHProgress

- (void)awakeFromNib
{
    self.roundedCorners = 2;
    self.progressLabel.textColor = [UIColor whiteColor];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    [super setProgress:progress animated:animated];
    
    NSString *text = [NSString stringWithFormat:@"%.1f%%", progress * 100];
    self.progressLabel.text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
    if (progress*100 >99) {
        self.hidden = YES;
    }else{
        self.hidden = NO;
    }
}

@end
