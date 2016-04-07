//
//  AHCommentVC.m
//  BaiJie
//
//  Created by Andy Hurricane on 4/6/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import "AHCommentVC.h"
#import "AHTopicCell.h"
typedef enum {
    AHCommentSectionTypeMainTopic=0,
    AHCOmmentSectionTypeTopComment,
    AHCOmmentSectionTypeNewComment
}AHCommentSectionType;


@interface AHCommentVC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tooBarBottomConstraint;
@property (weak, nonatomic) IBOutlet UIView *toolBarView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) AHTopicCell *topicCell;
@end

@implementation AHCommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [AHNotificationCenter addObserver:self selector:@selector(keyBoardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
-(void)initTableView{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 35, 0);self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 35, 0);
    self.topicCell = [AHTopicCell cell];
    self.topicCell.topic = self.topic;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == AHCommentSectionTypeMainTopic) {
        return 1;
    }
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == AHCommentSectionTypeMainTopic) {
        self.topicCell.topic = self.topic;
        return self.topicCell;
    }
    
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
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == AHCommentSectionTypeMainTopic) {
        return self.topic.cellHeight;
    }
    return 49;
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
