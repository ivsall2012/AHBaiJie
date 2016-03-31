//
//  AHLoginRegisterVC.m
//  BaiJie
//
//  Created by Andy Hurricane on 3/30/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import "AHLoginRegisterVC.h"

@interface AHLoginRegisterVC ()
@property (weak, nonatomic) IBOutlet UIButton *loginNow;

@end

@implementation AHLoginRegisterVC
- (IBAction)cancelBtn {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.loginNow setValue:@(5) forKeyPath:@"layer.cornerRadius"];
    [self.loginNow setValue:@(1) forKeyPath:@"layer.masksToBounds"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
