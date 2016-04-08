//
//  AHComment.m
//  BaiJie
//
//  Created by Andy Hurricane on 4/6/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import "AHComment.h"
#import <MJExtension.h>
#import "AHUser.h"
@implementation AHComment
- (NSString *)description
{
    return [NSString stringWithFormat:@"%@\n %@", self.user.username,self.user.profile_image];
}
-(CGFloat)cellHeight{
    if (!_cellHeight) {
        CGSize contentSize  = [self.content boundingRectWithSize:CGSizeMake(237, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:AHTextFont} context:nil].size;
        _cellHeight = 36 + contentSize.height + 8;
    }
    return _cellHeight;
}
@end
