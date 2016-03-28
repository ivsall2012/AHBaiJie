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
    return [self itemWithImage:image highImage:highImage target:target action:action settingBlock:nil];
}
+(instancetype) itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action settingBlock:(void (^)(UIButton *))settings{
    
    UIButton *buttonItem = [[UIButton alloc]init];
    [buttonItem setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [buttonItem setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    buttonItem.size = buttonItem.currentImage.size;
    [buttonItem addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    if (settings) {
        settings(buttonItem);
    }
    return [[self alloc]initWithCustomView:buttonItem];
}
@end
