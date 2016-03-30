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
#import <MJRefresh.h>

#define AHRecommendCurrentSelectedCategory self.categoryArray[self.categoryTableView.indexPathForSelectedRow.row]

@interface AHRecommendVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property (weak, nonatomic) IBOutlet UITableView *userTableView;
@property (nonatomic, strong) NSArray<AHRecommendCategory *> *categoryArray;
/**
 *  currentParams keeps track the latest request
 */
@property (nonatomic, strong) NSDictionary *currentParams;
@end

@implementation AHRecommendVC
static NSString * const recommendCategoryCellID = @"categoryCell";
static NSString * const recommendUserCellID = @"userCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的关注";
    [self initTableViews];
    [self setupRefreshControl];
    [self sendRequstForCategories];
    self.userTableView.rowHeight = 70;
    
}
-(void)setupRefreshControl{
    //                                 MJRefreshBackFooter doesn't work, you have to specify the class
    self.userTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    self.userTableView.mj_footer.hidden = YES;
}
-(void)checkFooterState{
    /*
     *  only 3 situations need to check footer state --> 
     *  all come to one route, [self.userTableView reloadData] which is where it goes when data is ready
     *
     *  1) when switching to new category
     *  2) scroll down to load newest data(have to destroy old data though)
     *  3) scroll up to load more data see if this is the last batch
     */
    AHRecommendCategory *currentCategory = AHRecommendCurrentSelectedCategory;
    self.userTableView.mj_footer.hidden = (currentCategory.users.count == 0);
    if (!self.userTableView.mj_footer.hidden) {
        // if not hidden then decide which state the footer wnats to display
        if (currentCategory.total == currentCategory.users.count) {
            // last batch
            [self.userTableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            // current total data models not reaching total yet, end refreshing
            [self.userTableView.mj_footer endRefreshing];
        }
    }

}
-(void)loadMoreUsers{
    AHRecommendCategory *category = AHRecommendCurrentSelectedCategory;
    NSDictionary *params = @{@"a":@"list",@"c":@"subscribe",@"category_id":@(category.id),@"page":@(++category.currentPage)};
    self.currentParams = params;
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php"
                             parameters:params
                               progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *users = [AHRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        // you can't just assign category.users = users, one is mutable, one is not, so just addObjectsFromArray
        [category.users addObjectsFromArray:users];
        
        // here, if the category is not current, we save data for later
        if(self.currentParams != params) return;
        
        [self.userTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.currentParams != params) return;
        
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        
        [self.userTableView.mj_footer endRefreshing];
    }];
}
-(void)loadNewUsers{
    AHRecommendCategory *category = AHRecommendCurrentSelectedCategory;
    // first for user list, set page to 1
    category.currentPage =1;
    AHLog(@"enter loadNewUsers id:%ld %@",category.id,category.name);
    NSDictionary *params = @{@"a":@"list",@"c":@"subscribe",@"category_id":@(category.id),@"page":@(category.currentPage)};
    self.currentParams = params;
    
    
    // dispatch delay makes current category not accurate, for previous calls, when fast switching so get category assignment outside
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php"
             parameters:params
               progress:^(NSProgress * _Nonnull downloadProgress) {
                   
               } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                   
                   
                   NSArray *users = [AHRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
                   
                   // for scrool down refresh
                   [category.users removeAllObjects];
                   
                   // you can't just assign category.users = users, one is mutable, one is not, so just addObjectsFromArray
                   [category.users addObjectsFromArray:users];
                   
                   category.total = [responseObject[@"total"] integerValue];
                   
                   // here, if the category is not current, we save data for later
                   AHLog(@"loadNewUsers: id:%ld %@",category.id,category.name);
                   if(self.currentParams != params) return;
                   
                   [self.userTableView reloadData];
                   [self.userTableView.mj_header endRefreshing];
                   
               } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                   
                   if (self.currentParams != params) return;
                   

                   [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
                   
                   [self.userTableView.mj_header endRefreshing];
               }];
    });
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
-(void)sendRequstForCategories{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD show];
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:@{@"a":@"category",@"c":@"subscribe"} progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.categoryArray = [AHRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.categoryTableView reloadData];
        [SVProgressHUD dismiss];
        //                                         creating indexPath for row, not collectionView's cell(item)
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        // above instance method won't call delegate method, so we call it ourselves
        [self.userTableView.mj_header beginRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:error.debugDescription];
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.categoryTableView) {
        return self.categoryArray.count;
    }else{
        AHRecommendCategory *category = self.categoryArray[self.categoryTableView.indexPathForSelectedRow.row];
        [self checkFooterState];
        return category.users.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.categoryTableView) {
        AHRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:recommendCategoryCellID];
        cell.category = self.categoryArray[indexPath.row];
        return cell;
    }else {
        AHRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:recommendUserCellID];
        AHRecommendCategory *category = self.categoryArray[self.categoryTableView.indexPathForSelectedRow.row];
        cell.user = category.users[indexPath.row];
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.categoryTableView) {
        [self.userTableView.mj_header endRefreshing];
        [self.userTableView.mj_footer endRefreshing];
        
        AHRecommendCategory *category = AHRecommendCurrentSelectedCategory;
        AHLog(@"didSelectRowAtIndexPath id:%ld %@",category.id,category.name);
        // ues if else statment!!!
        if (category.users.count) {
            AHLogFunc;
            [self.userTableView reloadData];
        }else{
             AHLog(@"didSelectRowAtIndexPath %@ PointA",category.name);
            // category.users.count doesn't matter you gotta refresh table view anyway, or empty it out when switching
            [self.userTableView reloadData];
            // first time load refresh data through refreshControl
            [self.userTableView.mj_header beginRefreshing];
            AHLog(@"didSelectRowAtIndexPath %@ PointB",category.name);
        }

    }
}
-(void)dealloc{
    [[AFHTTPSessionManager manager].operationQueue cancelAllOperations];
}
@end
