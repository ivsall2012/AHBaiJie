//
//  AHCommentUserIconButton.m
//  BaiJie
//
//  Created by Andy Hurricane on 4/7/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import "AHCommentUserIconButton.h"

@implementation AHCommentUserIconButton

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, 0, contentRect.size.width, contentRect.size.height);
}

@end
