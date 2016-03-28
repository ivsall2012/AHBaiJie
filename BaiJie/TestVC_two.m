//
//  TestVC_two.m
//  AHWeibo
//
//  Created by Andy Hurricane on 2/15/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import "TestVC_two.h"
#import "TestVC_three.h"
@interface TestVC_two ()

@end

@implementation TestVC_two

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    TestVC_three *three = [[TestVC_three alloc]init];
    three.title = @"i'm three";
    [self.navigationController pushViewController:three animated:YES];
}

@end
