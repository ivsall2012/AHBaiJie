//
//  AHRecommendVC.m
//  BaiJie
//
//  Created by Andy Hurricane on 3/28/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import "AHRecommendVC.h"
#import <SVProgressHUD.h>
#import <AFNetworking.h>
#import "AHRecommendCategory.h"
#import <MJExtension.h>
#import "AHRecommendCategoryCell.h"
#import "AHRecommendUserCell.h"
#import "AHRecommendUser.h"
@interface AHRecommendVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property (weak, nonatomic) IBOutlet UITableView *userTableView;
@property (nonatomic, strong) NSArray<AHRecommendCategory *> *categoryArray;
@property (nonatomic, strong) NSArray<AHRecommendUser *> *userArray;
@end

@implementation AHRecommendVC
static NSString * const recommendCategoryCellID = @"categoryCell";
static NSString * const recommendUserCellID = @"userCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的关注";
    [self initTableViews];
    [self sendRequstForCategory];
    self.userTableView.rowHeight = 70;
    
}
-(void)initTableViews{
    [self registerCells];
    // this line lets both table views have no insets so that we can setup their insets specifically later.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
}
-(void)registerCells{
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([AHRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:recommendCategoryCellID];
    
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([AHRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:recommendUserCellID];
    
}
-(void)sendRequstForCategory{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD show];
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:@{@"a":@"category",@"c":@"subscribe"} progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.categoryArray = [AHRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.categoryTableView reloadData];
        [SVProgressHUD dismiss];
        //                                               creating indexPath for row, not collectionView's cell(item)
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:error.debugDescription];
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.categoryTableView) {
        return self.categoryArray.count;
    }else{
        return self.userArray.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.categoryTableView) {
        AHRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:recommendCategoryCellID];
        cell.category = self.categoryArray[indexPath.row];
        return cell;
    }else {
        AHRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:recommendUserCellID];
        cell.user = self.userArray[indexPath.row];
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.categoryTableView) {
        AHRecommendCategory *category = self.categoryArray[indexPath.row];
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:@{@"a":@"list",@"c":@"subscribe",@"category_id":@(category.id)} progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            self.userArray = [AHRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            [self.userTableView reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            AHLog(@"error:%@",error);
        }];
    }
}
@end
