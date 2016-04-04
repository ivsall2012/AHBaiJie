//
//  AHTopicCellPictureView.m
//  BaiJie
//
//  Created by Andy Hurricane on 4/3/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import "AHTopicCellPictureView.h"
#import "AHTopic.h"
#import <UIImageView+WebCache.h>
#import "AHProgress.h"
#import "AHFullPictureVC.h"
@interface AHTopicCellPictureView()
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UIButton *fullPicBtn;

@property (weak, nonatomic) IBOutlet UIImageView *gifView;

@property (weak, nonatomic) IBOutlet AHProgress *progressView;

@end
@implementation AHTopicCellPictureView
-(void)awakeFromNib{
    self.autoresizingMask = UIViewAutoresizingNone;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImage)]];
}
-(void)tapImage{
    AHFullPictureVC *fullVC = [[AHFullPictureVC alloc]init];
    fullVC.topic = self.topic;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window.rootViewController presentViewController:fullVC animated:NO completion:nil];
}
+(instancetype)pictureView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
-(void)setTopic:(AHTopic *)topic{
    _topic = topic;
    
    [self.progressView setProgress:topic.imageProgress animated:NO];
    
    [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:topic.largeImage] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        CGFloat progress = 1.0 * receivedSize/expectedSize;
        topic.imageProgress = progress;
        [self.progressView setProgress:progress animated:NO];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
    
    NSString *urlExtension = topic.largeImage.pathExtension;
    self.gifView.hidden = ![urlExtension.lowercaseString isEqualToString:@"gif"];
    if (topic.isPictureTooBig) {
        self.fullPicBtn.hidden = NO;
        self.mainImageView.contentMode = UIViewContentModeTop;
    }else{
        self.fullPicBtn.hidden = YES;
        self.mainImageView.contentMode = UIViewContentModeScaleToFill;
    }
}
@end
