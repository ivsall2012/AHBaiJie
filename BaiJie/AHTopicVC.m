//
//  AHTopicVC.m
//  BaiJie
//
//  Created by Andy Hurricane on 4/2/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import "AHTopicVC.h"

#import <AFNetworking.h>
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import <MJRefresh.h>
#import "AHTopic.h"
#import "AHTopicCell.h"
#import "AHCommentVC.h"


@interface AHTopicVC ()
@property (nonatomic, copy) NSString *maxtime;
@property (nonatomic, strong) NSMutableArray *topicArray;
@property (nonatomic, strong) NSDictionary *params;
@end

@implementation AHTopicVC
static NSString *TopicCellID = @"TopicCellID";

-(NSMutableArray *)topicArray{
    if (!_topicArray) {
        _topicArray = [NSMutableArray array];
    }
    return _topicArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupRefreshControl];
    [self registerTopicCell];
    self.tableView.backgroundColor = [UIColor clearColor];
    
}
-(void)registerTopicCell{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([AHTopicCell class]) bundle:nil] forCellReuseIdentifier:TopicCellID];
}
-(void)setupRefreshControl{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    [self.tableView.mj_header beginRefreshing];
    [self.tableView.mj_header setAutomaticallyChangeAlpha:YES];
    
}
-(void)loadMoreTopics{
    [self.tableView.mj_header endRefreshing];
    NSDictionary *params = @{@"a":@"list",@"c":@"data",@"type":@(self.topicType),@"maxtime":self.maxtime};
    self.params = params;
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        if(self.params != params) return;
        NSMutableArray *newTopics = [AHTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        self.maxtime = responseObject[@"info"][@"maxtime"];
        [self.topicArray addObjectsFromArray:newTopics];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
-(void)loadNewTopics{
    [self.tableView.mj_footer endRefreshing];
    NSDictionary *params = @{@"a":@"list",@"c":@"data",@"type":@(self.topicType)};
    self.params = params;
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        if(self.params != params) return;
        [responseObject writeToFile:@"/Users/Hurricane/Go/jie.plist" atomically:YES];
        NSMutableArray *newTopics = [AHTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        self.maxtime = responseObject[@"info"][@"maxtime"];
        self.topicArray = newTopics;
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.mj_footer.hidden = self.topicArray.count == 0;
    return self.topicArray.count;
}
-(AHTopicCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AHTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:TopicCellID];
    AHTopic *topic = self.topicArray[indexPath.row];
    cell.topic = topic;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    AHTopic *topic = self.topicArray[indexPath.row];
    return topic.cellHeight;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AHTopic *selectedTopic = self.topicArray[indexPath.row];
    AHCommentVC *commentVC = [[AHCommentVC alloc]init];
    commentVC.topic = selectedTopic;
    [self.navigationController pushViewController:commentVC animated:YES];
    
}
@end