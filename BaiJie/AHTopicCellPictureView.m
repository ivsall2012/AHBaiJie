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
@interface AHTopicCellPictureView()
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UIButton *fullPicBtn;

@property (weak, nonatomic) IBOutlet UIImageView *gifView;


@end
@implementation AHTopicCellPictureView
-(void)awakeFromNib{
    self.autoresizingMask = UIViewAutoresizingNone;
}
+(instancetype)pictureView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
-(void)setTopic:(AHTopic *)topic{
    _topic = topic;
    
    [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:topic.largeImage] placeholderImage:nil];
    
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
