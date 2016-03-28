//
//  UIBarButtonItem+Extension.h
//  BaiJie
//
//  Created by Andy Hurricane on 3/27/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+(instancetype) itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
// it's important to notice that, for settingBlock, in interface it's (UIButton *button), BUT in implement the parameter is ommited, (UIButton *)
+(instancetype) itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action settingBlock:(void (^)(UIButton *button))settings;
@end
