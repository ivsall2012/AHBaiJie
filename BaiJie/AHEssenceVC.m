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
    
    [self setupTableViews];
    [self SetupSectionTabBar];
    [self setupMainScrollView];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self.sectionTabBar selectTabBarByTitle:@"视频"];
    });
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
    
    [self scrollViewDidEndScrollingAnimation:mainScrollView];
    
    
}
-(void)setupTableViews{
    AHAllKindsVC *allVC = [[AHAllKindsVC alloc]init];
    allVC.title = @"推荐";
    
    AHVideoVC *videoVC = [[AHVideoVC alloc]init];
    videoVC.title = @"视频";
    
    AHPictureVC *pictureVc = [[AHPictureVC alloc]init];
    pictureVc.title = @"图片";
    
    AHJokeVC *jokeVC = [[AHJokeVC alloc]init];
    jokeVC.title = @"段子";
    
    AHVoiceVC *voiceVC = [[AHVoiceVC alloc]init];
    voiceVC.title = @"声音";
    
    
//    self.childViewControllers = @[allVC,videoVC,voiceVC,pictureVc,jokeVC];
    [self setValue:@[allVC,videoVC,pictureVc,jokeVC,voiceVC] forKey:@"childViewControllers"];
}
-(void)SetupSectionTabBar{
    AHSectionTabBar *sectionTabBar = [[AHSectionTabBar alloc]init];
    sectionTabBar.width = self.view.width;
    sectionTabBar.height = 35;
    sectionTabBar.X = 0;
    sectionTabBar.Y = 64;
    sectionTabBar.delegate = self;
    for (UIViewController *vc in self.childViewControllers) {
        [sectionTabBar addTabBarByTitle:vc.title];
    }
    [self.view addSubview:sectionTabBar];
    self.sectionTabBar = sectionTabBar;

}

-(void)clickTag{
    AHRecommendSubsribeVC *recommendSubcribeVC = [[AHRecommendSubsribeVC alloc]init];
    [self.navigationController pushViewController:recommendSubcribeVC animated:YES];
}
-(void)sectionTabBar:(AHSectionTabBar *)sectionTabBar didSelectionTabBarTitle:(NSString *)title{
    NSInteger index;
    for (int i=0; i<self.childViewControllers.count; i++) {
        UIViewController *vc = self.childViewControllers[i];
        if ([vc.title isEqualToString:title]) {
            index = i;
            break;
        }
    }
    
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
    // tableView will adjust its y automatically, cant skip these settings
    VC.tableView.X = scrollView.contentOffset.x;
    VC.tableView.Y = 0;
    
//    VC.tableView.bounds = scrollView.bounds; // dont have to tell VC size of their tableView. it affects tableView x/y,weird..
    VC.tableView.height = scrollView.height;
    VC.tableView.width = scrollView.width;

    CGFloat topInset = CGRectGetMaxY(self.sectionTabBar.frame);
    CGFloat bottomInset = self.tabBarController.tabBar.height;
    VC.tableView.contentInset = UIEdgeInsetsMake(topInset, 0, bottomInset, 0);
    VC.tableView.scrollIndicatorInsets = VC.tableView.contentInset;
    [self.mainScrollView addSubview:VC.tableView];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    // when stop scrolling, try to add views
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    // click button manually
    NSInteger page = scrollView.contentOffset.x/scrollView.width;
    UIViewController *vc = self.childViewControllers[page];
    [self.sectionTabBar selectTabBarByTitle:vc.title];
}
@end
