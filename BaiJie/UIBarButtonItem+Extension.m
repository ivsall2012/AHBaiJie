//
//  UIBarButtonItem+Extension.m
//  BaiJie
//
//  Created by Andy Hurricane on 3/27/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)
+(instancetype) itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action{
    UIButton *buttonItem = [[UIButton alloc]init];
    [buttonItem setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [buttonItem setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    buttonItem.size = buttonItem.currentImage.size;
    [buttonItem addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc]initWithCustomView:buttonItem];
}
@end
