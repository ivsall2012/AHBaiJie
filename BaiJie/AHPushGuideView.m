//
//  AHPushGuideView.m
//  BaiJie
//
//  Created by Andy Hurricane on 3/31/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import "AHPushGuideView.h"
@implementation AHPushGuideView
- (IBAction)dismiss {
    [self removeFromSuperview];
}
+(instancetype)pushGuide{
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
+(void)pushGuideCheck{
    
    NSString *key = @"CFBundleShortVersionString";
    NSString *sandBoxVerson = [AHUserDefault valueForKey:key];
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    if (![currentVersion isEqualToString:sandBoxVerson]) {
        // save current version
        [AHUserDefault setValue:currentVersion forKey:key];
        [AHUserDefault synchronize];
        
        // show pushGuide
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        AHPushGuideView *pushGuide = [self pushGuide];
        pushGuide.frame = window.bounds;
        [window addSubview:pushGuide];
    }
    
}
@end
