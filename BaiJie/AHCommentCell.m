//
//  AHCommentCell.m
//  BaiJie
//
//  Created by Andy Hurricane on 4/7/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import "AHCommentCell.h"
#import "AHStackButton.h"
#import "AHComment.h"
#import <UIImageView+WebCache.h>
#import "AHUser.h"
@interface AHCommentCell()

@property (weak, nonatomic) IBOutlet UIButton *iconView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *genderButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet AHStackButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *voicePlayButton;

@end


@implementation AHCommentCell
- (IBAction)clickVoiceButton:(UIButton *)button {
    NSArray *imagePathes = @[@"play-voice-icon-1",@"play-voice-icon-2",@"play-voice-icon-3"];
    NSMutableArray *images = [NSMutableArray array];
    for (NSString *path in imagePathes) {
        UIImage *image = [UIImage imageNamed:path];
        [images addObject:image];
    }
    button.imageView.animationImages = images;
    NSTimeInterval duration = [self.comment.voicetime doubleValue];
    button.imageView.animationDuration = 1;
    button.imageView.animationRepeatCount = duration;
    [button.imageView startAnimating];
}

- (void)awakeFromNib {
    self.genderButton.enabled = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setComment:(AHComment *)comment{
    _comment = comment;
    AHUser *user = comment.user;

    __weak UIButton *weakButton = self.iconView;
    [self.iconView.imageView sd_setImageWithURL:[NSURL URLWithString:user.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
       [weakButton setImage:image forState:UIControlStateNormal];
        
    }];
    
    
    if ([user.sex isEqualToString:@"f"]) {
        self.genderButton.selected = YES;
    }else{
        self.genderButton.selected = NO;
    }
    
    
    // random setting for text comments or voice
    if (arc4random_uniform(100)%2) {
        self.comment.voiceuri = @"fasdfads";
        self.comment.voicetime = [NSString stringWithFormat:@"%d",arc4random_uniform(5)+1];// from [0,5) +1 --> [1,6)
    }
    
    if (self.comment.voiceuri.length) {
        self.contentLabel.hidden =YES;
        self.voicePlayButton.hidden = NO;
        [self.voicePlayButton setTitle:[NSString stringWithFormat:@"%@''",self.comment.voicetime] forState:UIControlStateNormal];
    }else{
        self.contentLabel.hidden =NO;
        self.voicePlayButton.hidden = YES;
        self.contentLabel.text = comment.content;
    }
    self.nameLabel.text = user.username;
    
    [self.likeButton setTitle:[NSString stringWithFormat:@"+%@",comment.like_count] forState:UIControlStateNormal];
}
@end
