//
//  AHLoginTextField.m
//  BaiJie
//
//  Created by Andy Hurricane on 3/31/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import "AHLoginTextField.h"

@implementation AHLoginTextField

-(void)awakeFromNib{
    // to initialize placeholder color
    [self resignFirstResponder];
}
-(BOOL)becomeFirstResponder{
                                // it's keypath ok!!!!!
    [self setValue:self.textColor forKeyPath:@"_placeholderLabel.textColor"];
    return [super becomeFirstResponder];
}
-(BOOL)resignFirstResponder{
    
    [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    return [super resignFirstResponder];
}
@end
