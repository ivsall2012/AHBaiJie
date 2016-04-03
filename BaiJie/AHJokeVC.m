//
//  AHJokeVC.m
//  BaiJie
//
//  Created by Andy Hurricane on 3/31/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import "AHJokeVC.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import <MJRefresh.h>
#import "AHTopic.h"
#import "AHTopicCell.h"
@interface AHJokeVC ()
@property (nonatomic, copy) NSString *maxtime;
@property (nonatomic, strong) NSMutableArray *topicArray;
@property (nonatomic, strong) NSDictionary *params;
@end

@implementation AHJokeVC
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
    NSDictionary *params = @{@"a":@"list",@"c":@"data",@"type":@(29),@"maxtime":self.maxtime};
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
    NSDictionary *params = @{@"a":@"list",@"c":@"data",@"type":@(29)};
    self.params = params;
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        if(self.params != params) return;
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
@end
