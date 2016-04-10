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
#import "AHNavigationVC.h"
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
@property (nonatomic,assign) NSInteger total;
@property (nonatomic, weak) UIView *statusBarView;
@end

static NSString *commentID = @"commentID";
static UIWindow *window_;

@implementation AHCommentVC
-(UIView *)statusBarView{
    if (!_statusBarView) {
        UIView *statusBarView = [[UIView alloc]init];
        statusBarView.frame = window_.bounds;
        statusBarView.alpha = 0;
        [window_ addSubview:statusBarView];
        _statusBarView = statusBarView;
        
        UIButton *goBackButton = [[UIButton alloc]init];
        goBackButton.frame =CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/3, 20);
        [goBackButton setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [goBackButton setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [goBackButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        goBackButton.backgroundColor = AHRandomColor;
        [_statusBarView addSubview:goBackButton];
        
        UIButton *goTop = [[UIButton alloc]init];
        goTop.X = CGRectGetMaxX(goBackButton.frame);
        goTop.Y = goBackButton.Y;
        goTop.width = goBackButton.width;
        goTop.height = goBackButton.height;
        goTop.backgroundColor = AHRandomColor;
        [goTop setTitle:@"Top" forState:UIControlStateNormal];
        [goTop addTarget:self action:@selector(goTop) forControlEvents:UIControlEventTouchUpInside];
        [_statusBarView addSubview:goTop];
        
        UIButton *shareButton = [[UIButton alloc]init];
        shareButton.X = CGRectGetMaxX(goTop.frame);
        shareButton.Y = goTop.Y;
        shareButton.width = goTop.width;
        shareButton.height = goTop.height;
        [shareButton addTarget:self action:@selector(goShare) forControlEvents:UIControlEventTouchUpInside];
        shareButton.backgroundColor = AHRandomColor;
        [shareButton setTitle:@"分享" forState:UIControlStateNormal];
        [_statusBarView addSubview:shareButton];
        
        _statusBarView.alpha = 0;
        
    }
    return _statusBarView;
}
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
    self.title = @"评论";
    [self setupLightningMode];
    [self initTableView];
    [AHNotificationCenter addObserver:self selector:@selector(keyBoardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [self initRefreshControl];
    [self loadNewComments];
    
    
}
-(void)setupLightningMode{
    window_ = [[UIWindow alloc]init];
    window_.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, 20);
    window_.hidden = NO;
    window_.windowLevel = UIWindowLevelAlert;
    
    [self statusBarView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    [self.navigationController setNavigationBarHidden:YES];
    [UIView animateWithDuration:0.2 animations:^{
        window_.X = 0;
    }];

}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [UIView animateWithDuration:0.3 animations:^{
        self.statusBarView.alpha = 1;
    }];
}
-(BOOL)prefersStatusBarHidden{
    return YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [UIView animateWithDuration:0.2 animations:^{
        window_.X = [UIScreen mainScreen].bounds.size.width;
    }];
}
-(void)dealloc{
    window_.hidden = YES;
    window_ = nil;
}
-(void)goShare{
    AHLogFunc;
}
-(void)goTop{
    [self.tableView setContentOffset:CGPointMake(0, -20) animated:YES];
}
-(void)cancel{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initRefreshControl{
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
//    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer.hidden = YES;
//    [self.tableView.mj_header setAutomaticallyChangeAlpha:YES];
}
-(void)loadNewComments{
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:@{@"a":@"dataList",@"c":@"comment",@"data_id":self.topic.ID,@"hot":@(1)} progress:nil
      success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
          NSArray *comments = responseObject[@"data"];
          if (!comments.count) {
              self.tableView.mj_header.hidden = YES;
              return;
          }else{
              self.tableView.mj_header.hidden = NO;
          }
          
          self.commentArray = [AHComment mj_objectArrayWithKeyValuesArray:comments];
          self.topCommentArray = [AHComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
          AHComment *lastComment = [self.commentArray lastObject];
          self.lastcid = lastComment.ID;
          
          
          self.total = [responseObject[@"total"] integerValue];
          if (self.total <= self.commentArray.count) {
              self.tableView.mj_footer.hidden = YES;
          }else{
              self.tableView.mj_footer.hidden = NO;
          }
          [self.tableView.mj_header endRefreshing];
          
          [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        AHLogFunc;
    }];
}
-(void)loadMoreComments{
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:@{@"a":@"dataList",@"c":@"comment",@"data_id":self.topic.ID,@"lastcid":self.lastcid} progress:nil
    success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        if (![responseObject[@"data"] count]) {
            [self.tableView.mj_header endRefreshing];
            self.tableView.mj_header.hidden = YES;
            return;
        }else{
            self.tableView.mj_header.hidden = NO;
        }
        NSMutableArray *commentArray= [AHComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        [self.commentArray addObjectsFromArray:commentArray];
        AHComment *lastComment = [commentArray lastObject];
        self.lastcid = lastComment.ID;
        if (self.total <= self.commentArray.count) {
            self.tableView.mj_footer.hidden = YES;
            [self.tableView reloadData];
            return;
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        AHLogFunc;
    }];
}
-(void)initTableView{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 40, 0);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.topicCell = [AHTopicCell cell];
    self.topicCell.topic = self.topic;
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
        return self.topic.cellHeight + AHTopicCellMargin;
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
