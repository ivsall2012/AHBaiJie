//
//  AHEssenceVC.m
//  BaiJie
//
//  Created by Andy Hurricane on 3/27/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import "AHEssenceVC.h"
#import "UIBarButtonItem+Extension.h"
#import "AHRecommendSubsribeVC.h"
#import "AHSectionTabBar.h"

#import "AHAllKindsVC.h"
#import "AHVideoVC.h"
#import "AHVoiceVC.h"
#import "AHPictureVC.h"
#import "AHJokeVC.h"


#define AHNumberOfSectionTableViews 5
@interface AHEssenceVC ()<AHSectionTabBarDelegate,UIScrollViewDelegate>
@property (nonatomic, weak) AHSectionTabBar *sectionTabBar;
@property (nonatomic, weak) UIScrollView *mainScrollView;
@end

@implementation AHEssenceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(clickTag)];
    [self setupMainScrollView];
    [self setupTableViews];
    [self SetupSectionTabBar];
    
}
-(void)setupMainScrollView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *mainScrollView = [[UIScrollView alloc]init];
    mainScrollView.frame = self.view.bounds;
    mainScrollView.pagingEnabled = YES;
    mainScrollView.delegate = self;
    mainScrollView.contentSize = CGSizeMake(AHNumberOfSectionTableViews * mainScrollView.width, 0);
    [self.view insertSubview:mainScrollView atIndex:0];
    self.mainScrollView = mainScrollView;
    
    
}
-(void)setupTableViews{
    AHAllKindsVC *allVC = [[AHAllKindsVC alloc]init];
    AHVideoVC *videoVC = [[AHVideoVC alloc]init];
    AHVoiceVC *voiceVC = [[AHVoiceVC alloc]init];
    AHPictureVC *pictureVc = [[AHPictureVC alloc]init];
    AHJokeVC *jokeVC = [[AHJokeVC alloc]init];
    
//    self.childViewControllers = @[allVC,videoVC,voiceVC,pictureVc,jokeVC];
    [self setValue:@[allVC,videoVC,voiceVC,pictureVc,jokeVC] forKey:@"childViewControllers"];
}
-(void)SetupSectionTabBar{
    AHSectionTabBar *sectionTabBar = [[AHSectionTabBar alloc]init];
    sectionTabBar.width = self.view.width;
    sectionTabBar.height = 35;
    sectionTabBar.X = 0;
    sectionTabBar.Y = 64;
    sectionTabBar.delegate = self;
    [self.view addSubview:sectionTabBar];
    self.sectionTabBar = sectionTabBar;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.sectionTabBar selectButtonType:AHSectionTabBarButtonTypeRecommend];
}
-(void)clickTag{
    AHRecommendSubsribeVC *recommendSubcribeVC = [[AHRecommendSubsribeVC alloc]init];
    [self.navigationController pushViewController:recommendSubcribeVC animated:YES];
}
-(void)sectionTabBar:(AHSectionTabBar *)sectionTabBar didSelectionButtonType:(AHSectionTabBarButtonType)type{
    NSInteger index = type - AHSectionTabBarButtonTypeRecommend; // 0 1 2 3 4 for child VCs
    CGPoint offSet  = self.mainScrollView.contentOffset;
    offSet.x = index * self.mainScrollView.width;
    // this setter for offSet with animated param leads to scrollViewDidEndScrollingAnimation which is the place we add VCs' views
    [self.mainScrollView setContentOffset:offSet animated:YES];
    
}
#pragma mark - mainScrollView delegate
// when it sense offSet changes, try to add views
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    // here we need absolute page number -- index of child VCs
    NSInteger page = scrollView.contentOffset.x/scrollView.width;
    UITableViewController *VC = self.childViewControllers[page];
    if (VC.tableView.X ==0 ) {
        VC.tableView.X = scrollView.contentOffset.x;
        VC.tableView.Y = 0;
//        VC.tableView.bounds = scrollView.bounds; // dont have to tell VC size of their tableView
        CGFloat topInset = CGRectGetMaxY(self.sectionTabBar.frame);
        CGFloat bottomInset = self.tabBarController.tabBar.height;
        VC.tableView.contentInset = UIEdgeInsetsMake(topInset, 0, bottomInset, 0);
        [self.mainScrollView addSubview:VC.tableView];
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    // when stop scrolling, try to add views
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    // click button manually
    NSInteger page = scrollView.contentOffset.x/scrollView.width;
    AHSectionTabBarButtonType type = (AHSectionTabBarButtonType)((long)AHSectionTabBarButtonTypeRecommend + (long)page);
    [self sectionTabBar:self.sectionTabBar didSelectionButtonType:type];
}
@end
