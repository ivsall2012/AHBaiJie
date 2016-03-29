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
@interface AHRecommendVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property (nonatomic, strong) NSArray<AHRecommendCategory *> *categoryArray;
@end

@implementation AHRecommendVC
static NSString * const recommendCategoryCellID = @"categoryCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的关注";
    [self registerCategoryCell];
    [self sendRequstForCategory];
//    self.categoryTableView.backgroundColor = AHGlobelViewColor;
    
}
-(void)registerCategoryCell{
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([AHRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:recommendCategoryCellID];
    
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
    return self.categoryArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AHRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:recommendCategoryCellID];
    
    cell.category = self.categoryArray[indexPath.row];
    return cell;
}
@end
