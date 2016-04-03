//
//  AHTopic.m
//  BaiJie
//
//  Created by Andy Hurricane on 4/1/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import "AHTopic.h"

@implementation AHTopic
-(CGFloat)cellHeight{
    if (!_cellHeight) {
        CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width - 4*8;
        CGSize cellSize = [self.text boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:AHTextFont} context:nil].size;
        _cellHeight = 66 + cellSize.height + 35 + 10;
    }
    return _cellHeight;
}
@end
