//
//  AHTopicCell.m
//  BaiJie
//
//  Created by Andy Hurricane on 4/2/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import "AHTopicCell.h"
#import "AHTopic.h"
#import "AHTopicCellPictureView.h"
#import <UIImageView+WebCache.h>
#import "AHTopicCellVideoView.h"
#import "AHTopicCellVoiceView.h"

@interface AHTopicCell()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *timeStamp;
@property (weak, nonatomic) IBOutlet UIButton *ding;
@property (weak, nonatomic) IBOutlet UIButton *cai;
@property (weak, nonatomic) IBOutlet UIButton *repost;
@property (weak, nonatomic) IBOutlet UIButton *comment;
@property (weak, nonatomic) IBOutlet UILabel *contentText;
@property (nonatomic, weak) AHTopicCellPictureView *pictureView;
@property (nonatomic, weak) AHTopicCellVideoView *videoView;
@property (nonatomic, weak) AHTopicCellVoiceView *voiceView;
@end
@implementation AHTopicCell
-(AHTopicCellVoiceView *)voiceView{
    if (!_voiceView) {
        AHTopicCellVoiceView *voiceView= [AHTopicCellVoiceView voiceView];
        [self.contentView addSubview:voiceView];
        self.voiceView = voiceView;
    }
    return _voiceView;
}
-(AHTopicCellVideoView *)videoView{
    if (!_videoView) {
        AHTopicCellVideoView *videoView = [AHTopicCellVideoView videoView];
        _videoView = videoView;
        [self.contentView addSubview:videoView];
        
    }
    return _videoView;
}
-(AHTopicCellPictureView *)pictureView{
    if (!_pictureView) {
        AHTopicCellPictureView *pictureView = [AHTopicCellPictureView pictureView];
        [self.contentView addSubview:pictureView];
        self.pictureView = pictureView;
        
    }
    return _pictureView;
}
- (void)awakeFromNib {
    self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}
+(instancetype)cell{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setTopic:(AHTopic *)topic{
    _topic = topic;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.name.text = topic.name;
    self.timeStamp.text = topic.created_at;
    [self.ding setTitle:topic.ding forState:UIControlStateNormal];
    [self.cai setTitle:topic.cai forState:UIControlStateNormal];
    [self.repost setTitle:topic.repost forState:UIControlStateNormal];
    [self.comment setTitle:topic.comment forState:UIControlStateNormal];
    if (self.topic.type == AHTopicTypePicture) {
        self.voiceView.hidden = YES;
        self.videoView.hidden =YES;
        self.pictureView.hidden = NO;
        
        self.pictureView.frame = topic.pictureFrame;
        self.pictureView.topic = topic;
    }else if(self.topic.type == AHTopicTypeVideo){
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.hidden = NO;
        
        self.videoView.frame = topic.videoFrame;
        self.videoView.topic = topic;
    }else if (self.topic.type == AHTopicTypeVoice){
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        self.voiceView.hidden = NO;
        
        self.voiceView.frame = topic.voiceFrame;
        self.voiceView.topic = topic;
    }else{
        // joke, no extra view needed
        self.pictureView.hidden =YES;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
        
    }
    self.contentText.text = topic.text;
}

-(void)setFrame:(CGRect)frame{
    CGFloat margin = 8.0;
    frame.origin.y += margin;
    frame.size.height = self.topic.cellHeight - margin;
    frame.origin.x = margin;
    frame.size.width -= 2 *margin;

    
    [super setFrame:frame];
}
                      
@end
