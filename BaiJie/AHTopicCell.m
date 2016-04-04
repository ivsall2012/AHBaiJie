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

@end
@implementation AHTopicCell
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
        self.pictureView.frame = topic.pictureFrame;
        self.pictureView.topic = topic;
        
    }
    self.contentText.text = topic.text;
}
-(void)setFrame:(CGRect)frame{
    CGFloat margin = 8.0;
    frame.origin.y += margin;
    frame.size.height -= margin;
    frame.origin.x = margin;
    frame.size.width -= 2 *margin;
    
    
    [super setFrame:frame];
}
@end
