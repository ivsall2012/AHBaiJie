//
//  AHTopicCellVideoView.m
//  BaiJie
//
//  Created by Andy Hurricane on 4/6/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import "AHTopicCellVideoView.h"
#import <UIImageView+WebCache.h>
#import "AHTopic.h"

@interface AHTopicCellVideoView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLengthLabel;
@property (weak, nonatomic) IBOutlet UIButton *playButton;

@end

@implementation AHTopicCellVideoView
-(void)awakeFromNib{
    self.autoresizingMask = UIViewAutoresizingNone;
}
- (IBAction)play:(UIButton *)sender {
    
}
+(instancetype)videoView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
-(void)setTopic:(AHTopic *)topic{
    _topic = topic;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.largeImage] placeholderImage:nil];
    self.playCountLabel.text = topic.playcount;
    self.timeLengthLabel.text = [self timeLengthForMinuteFormatWithSecond:topic.videotime];
}
-(NSString *)timeLengthForMinuteFormatWithSecond:(NSString *)seconds{
    int minute = [seconds intValue]/60;
    int second = [seconds intValue]%60;
    return [NSString stringWithFormat:@"%.02d:%.0d",minute,second];
}
@end
