//
//  TestVC_one.m
//  AHWeibo
//
//  Created by Andy Hurricane on 2/15/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import "TestVC_one.h"
#import "TestVC_two.h"
#import "UIView+extension.h"
@interface TestVC_one ()

@end

@implementation TestVC_one

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    TestVC_two *two = [[TestVC_two alloc]init];
    two.title = @"two";
    
    
    
    
    
    [self.navigationController pushViewController:two animated:YES];
}
-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)more{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
