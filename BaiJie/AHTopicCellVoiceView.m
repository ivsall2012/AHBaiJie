//
//  AHTopicCellVoiceView.m
//  BaiJie
//
//  Created by Andy Hurricane on 4/6/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import "AHTopicCellVoiceView.h"
#import <UIImageView+WebCache.h>
#import "AHTopic.h"

@interface AHTopicCellVoiceView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UILabel *playCount;
@property (weak, nonatomic) IBOutlet UILabel *timeLength;


@end



@implementation AHTopicCellVoiceView
+(instancetype)voiceView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}
-(void)awakeFromNib{
    self.autoresizingMask = UIViewAutoresizingNone;
}
-(void)setTopic:(AHTopic *)topic{
    _topic = topic;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.largeImage] placeholderImage:nil];
    self.playCount.text = topic.playcount;
    self.timeLength.text = [self timeLengthForMinuteFormatWithSecond:topic.voicetime];
    
}
-(NSString *)timeLengthForMinuteFormatWithSecond:(NSString *)seconds{
    int minute = [seconds intValue]/60;
    int second = [seconds intValue]%60;
    return [NSString stringWithFormat:@"%.02d:%.0d",minute,second];
}
@end
