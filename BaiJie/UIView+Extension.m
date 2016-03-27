//
//  UIButton+extension.m
//  AHWeibo
//
//  Created by Andy Hurricane on 2/15/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (extension)
-(void)setX:(CGFloat)X{
    CGRect frame = self.frame;
    frame.origin.x = X;
    self.frame = frame;
}
-(void)setY:(CGFloat)Y{
    CGRect frame = self.frame;
    frame.origin.y = Y;
    self.frame = frame;
}
-(void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}
-(void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
-(void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
-(void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

-(CGFloat)X{
    return self.frame.origin.x;
}
-(CGFloat)Y{
    return self.frame.origin.y;
}
-(CGPoint)origin{
    return self.frame.origin;
}
-(CGSize)size{
    return self.frame.size;
}
-(CGFloat)width{
    return self.frame.size.width;
}
-(CGFloat)height{
    return self.frame.size.height;
}
-(CGFloat)centerX{
    return self.center.x;
}
-(CGFloat)centerY{
    return self.center.y;
}
-(void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}
-(void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}
@end
