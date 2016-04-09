//
//  AHCommentVC.m
//  BaiJie
//
//  Created by Andy Hurricane on 4/6/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import "AHCommentVC.h"
#import "AHTopicCell.h"
#import <MJRefresh.h>
#import "AHCommentCell.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import "AHComment.h"
typedef enum {
    AHCommentSectionTypeMainTopic=0,
    AHCOmmentSectionTypeTopComment,
    AHCOmmentSectionTypeNewComment
}AHCommentSectionType;


@interface AHCommentVC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *toolBarView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) AHTopicCell *topicCell;
@property (nonatomic, strong) NSArray *topCommentArray;
@property (nonatomic, strong) NSMutableArray *commentArray;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tooBarBottomConstraint;
@property (nonatomic,copy) NSString *lastcid;
@end

static NSString *commentID = @"commentID";
@implementation AHCommentVC
-(NSArray *)topCommentArray{
    if (!_topCommentArray) {
        NSArray *topCommentArray = [NSArray array];
        _topCommentArray = topCommentArray;
    }
    return _topCommentArray;
}
-(NSMutableArray *)commentArray{
    if (!_commentArray) {
        NSMutableArray *commentArray = [NSMutableArray array];
        _commentArray = commentArray;
    }
    return _commentArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTableView];
    [AHNotificationCenter addObserver:self selector:@selector(keyBoardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [self initRefreshControl];
}
-(void)initRefreshControl{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
    [self.tableView.mj_header beginRefreshing];
    [self.tableView.mj_header setAutomaticallyChangeAlpha:YES];
}
-(void)loadNewComments{
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:@{@"a":@"dataList",@"c":@"comment",@"data_id":self.topic.ID,@"hot":@(1)} progress:nil
      success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
          self.commentArray = [AHComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
          self.topCommentArray = [AHComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
          AHComment *lastComment = [self.commentArray lastObject];
          self.lastcid = lastComment.ID;
          [self.tableView.mj_header endRefreshing];
          [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
-(void)loadMoreComments{
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:@{@"a":@"dataList",@"c":@"comment",@"data_id":self.topic.ID,@"lastcid":self.lastcid} progress:nil
    success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        NSMutableArray *commentArray= [AHComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        AHLog(@"%ld",commentArray.count);
        [self.commentArray addObjectsFromArray:commentArray];
        AHComment *lastComment = [commentArray lastObject];
        self.lastcid = lastComment.ID;
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
-(void)initTableView{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 35, 0);self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 35, 0);
    self.topicCell = [AHTopicCell cell];
    self.topicCell.topic = self.topic;
    self.topicCell.toolBarToBottom.constant = 20;
    [self.view layoutIfNeeded];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([AHCommentCell class]) bundle:nil] forCellReuseIdentifier:commentID];

    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.topCommentArray.count) {
        return 3;
    }
    if (self.commentArray.count) {
        return 2;
    }
    return 1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == AHCommentSectionTypeMainTopic) {
        return 1;
    }
    if (section == AHCOmmentSectionTypeTopComment) {
        NSInteger topCount = self.topCommentArray.count;
        NSInteger count = self.commentArray.count;
        return topCount?topCount:count;
    }else if(section == AHCOmmentSectionTypeNewComment && self.commentArray.count){
        
        return self.commentArray.count;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == AHCommentSectionTypeMainTopic) {
        self.topicCell.topic = self.topic;
        return self.topicCell;
    }
    
    AHCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:commentID];
    if (indexPath.section == 1) {
        NSInteger topCount =self.topCommentArray.count;
        if (topCount) {
            cell.comment = self.topCommentArray[indexPath.row];
        }else{
            cell.comment = self.commentArray[indexPath.row];
        }
    }else{
        cell.comment = self.commentArray[indexPath.row];
    }
    return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return nil;
    }
    if (section == 1) {
        return self.topCommentArray.count?@"最热评论":@"最新评论";
    }
    return @"最新评论";
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return self.topic.cellHeight;
    }
    AHComment *comment = nil;
    if (indexPath.section == 1) {
        if (self.topCommentArray.count) {
            comment = self.topCommentArray[indexPath.row];
            return comment.cellHeight;
        }
    }
    comment = self.commentArray[indexPath.row];
    return comment.cellHeight;
    
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
