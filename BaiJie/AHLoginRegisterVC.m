//
//  AHLoginRegisterVC.m
//  BaiJie
//
//  Created by Andy Hurricane on 3/30/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import "AHLoginRegisterVC.h"

@interface AHLoginRegisterVC ()

@end

@implementation AHLoginRegisterVC
- (IBAction)cancelBtn {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
