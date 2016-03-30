//
//  AHRecommendSubscribeCell.m
//  BaiJie
//
//  Created by Andy Hurricane on 3/30/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import "AHRecommendSubscribeCell.h"
#import <UIImageView+WebCache.h>
#import "AHRecommendSubsriber.h"
@interface AHRecommendSubscribeCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *followerLabel;

@end
@implementation AHRecommendSubscribeCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setSubscriber:(AHRecommendSubsriber *)subscriber{
    _subscriber = subscriber;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:subscriber.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = subscriber.theme_name;
    self.followerLabel.text = subscriber.sub_number;
}
-(void)setFrame:(CGRect)frame{
    
    frame.origin.x = 7;
    frame.size.width -= frame.origin.x *2;
    frame.size.height -= 3;
    
    // if place super method before settings, it wont work
    [super setFrame:frame];
}

/*
 *  autolayout crashes
 */
//-(void)layoutSubviews{
//    [super layoutSubviews];
//    
//    self.X = 7;
//    self.width -= self.X *2;
//    self.height -= 3;
//}
@end
