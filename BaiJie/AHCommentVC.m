//
//  AHCommentVC.m
//  BaiJie
//
//  Created by Andy Hurricane on 4/6/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import "AHCommentVC.h"

@interface AHCommentVC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tooBarBottomConstraint;
@property (weak, nonatomic) IBOutlet UIView *toolBarView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation AHCommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    [AHNotificationCenter addObserver:self selector:@selector(keyBoardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
-(void)initTableView{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 35, 0);self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 35, 0);
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"myself";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell= [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    NSString *content = [NSString stringWithFormat:@"row: %ld",indexPath.row];
    cell.textLabel.text = content;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"random:%u",arc4random_uniform(999)];
    return cell;
}

#pragma mark - toolBar handling
-(void)keyBoardWillChangeFrame:(NSNotification *)notification{
    CGFloat animationDuration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect endFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat endY = self.view.height - endFrame.origin.y;
    self.tooBarBottomConstraint.constant = endY;
    [UIView animateWithDuration:animationDuration animations:^{
//        self.tooBarBottomConstraint.constant = endY;// can be outside or inside
        [self.toolBarView layoutIfNeeded];
    }];
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
@end
