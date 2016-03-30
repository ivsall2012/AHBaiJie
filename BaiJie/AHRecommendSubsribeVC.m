//
//  AHRecommendSubsribeVC.m
//  BaiJie
//
//  Created by Andy Hurricane on 3/30/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import "AHRecommendSubsribeVC.h"
#import <SVProgressHUD.h>
#import <AFNetworking.h>
#import <MJExtension.h>
#import "AHRecommendSubsriber.h"
#import "AHRecommendSubscribeCell.h"

@interface AHRecommendSubsribeVC ()
@property (nonatomic, strong) NSArray *subscriberArray;
@end

@implementation AHRecommendSubsribeVC
static NSString * const recommendSubscribeCellID = @"subscribeCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    [self registerCell];
    [self requestForSubscribers];
    
}
-(void)initTableView{
    self.title = @"推荐订阅";
    self.tableView.rowHeight = 70;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
-(void)registerCell{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([AHRecommendSubscribeCell class]) bundle:nil] forCellReuseIdentifier:recommendSubscribeCellID];
}
-(void)requestForSubscribers{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD show];
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:@{@"a":@"tag_recommend",@"action":@"sub",@"c":@"topic"} progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.subscriberArray = [AHRecommendSubsriber mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"error"];
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.subscriberArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AHRecommendSubscribeCell *cell = [tableView dequeueReusableCellWithIdentifier:recommendSubscribeCellID];
    cell.subscriber = self.subscriberArray[indexPath.row];
    return cell;
}
@end
