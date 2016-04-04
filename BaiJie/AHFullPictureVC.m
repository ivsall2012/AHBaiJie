//
//  AHFullPictureVC.m
//  BaiJie
//
//  Created by Andy Hurricane on 4/3/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import "AHFullPictureVC.h"
#import "AHTopic.h"
#import <UIImageView+WebCache.h>
#import "AHProgress.h"
#import <SVProgressHUD.h>

@interface AHFullPictureVC ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet AHProgress *progressView;
@property (nonatomic, weak) UIImageView *imageView;
@end

@implementation AHFullPictureVC
- (IBAction)save {
    if (self.imageView.image ==nil) {
        [SVProgressHUD showErrorWithStatus:@"还没下完呢~等下吧."];
        return;
    }
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), @"saveImageFlag");
    
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (contextInfo == nil) {
        // we passed nil as contentInfo, if there's contextInfo being assigned -- something wrong
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }else{
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
          
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // cant add gesture here since it would swallow any click on it
//    [self.scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImage)]];

}
-(IBAction)tapImage{
    [self dismissViewControllerAnimated:NO completion:nil];
}
-(void)setTopic:(AHTopic *)topic{
    _topic = topic;
    
    
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    UIImageView *imageView = [[UIImageView alloc]init];
    CGFloat pictureH = (AHTopicCellMaxWidth * topic.height)/topic.width;
    self.view.backgroundColor = [UIColor blackColor]; // just to wake up self.view...
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImage)]];
    imageView.size = CGSizeMake(AHTopicCellMaxWidth, pictureH);
    if (pictureH > screenH) {
        imageView.centerX = screenW*0.5;
        imageView.Y = 50;
        self.scrollView.contentSize = CGSizeMake(0, pictureH);
    }else{
        // here self.scrollView haven't waken up frim nib till the view is used(view is lazy loading even in xib)
        // dont use self.view --> xib scale
        imageView.centerY = screenH*0.5;
        imageView.centerX = screenW*0.5;
        
        self.scrollView.contentSize = CGSizeZero;
    }
    
    
    [self.progressView setProgress:topic.imageProgress animated:NO];
    [imageView sd_setImageWithURL:[NSURL URLWithString:topic.largeImage] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        CGFloat progress = 1.0 * receivedSize/expectedSize;
        topic.imageProgress = progress;
        self.progressView.hidden = NO;
        [self.progressView setProgress:progress animated:NO];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
    
}

@end
