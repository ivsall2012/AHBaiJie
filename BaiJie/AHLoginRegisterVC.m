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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginFrameRightConstrant;

@end

@implementation AHLoginRegisterVC
- (IBAction)clickRegisterBtn:(UIButton *)registerBtn {
    [self.view endEditing:YES];
    registerBtn.selected = !registerBtn.selected;
    
    // the constant here is the same constant in autolayout pannel -- offset, not the exact x of the edge.
    if (self.loginFrameRightConstrant.constant == 0) {
        self.loginFrameRightConstrant.constant = -self.view.width;
    }else{
        self.loginFrameRightConstrant.constant = 0;
    }
    [UIView animateWithDuration:0.25 animations:^{
        // layoutIfNeeded has to be placed within animation and the setting can be here or outside, dont know why yet:)
        [self.view layoutIfNeeded];
    }];
    
}
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
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    // have to use endEditing, resignFirstResponder wont work
    [self.view endEditing:YES];
}
@end
