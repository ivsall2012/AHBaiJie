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

@end


@implementation AHCommentCell

- (void)awakeFromNib {
    self.iconView.contentEdgeInsets = UIEdgeInsetsZero;
    self.iconView.imageEdgeInsets = UIEdgeInsetsZero;
    self.iconView.titleEdgeInsets = UIEdgeInsetsZero;
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
    
    self.nameLabel.text = user.username;
    self.contentLabel.text = comment.content;
    [self.likeButton setTitle:[NSString stringWithFormat:@"+%@",comment.like_count] forState:UIControlStateNormal];
}
@end
