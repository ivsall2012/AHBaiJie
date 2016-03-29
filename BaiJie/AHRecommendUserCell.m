//
//  AHRecommendUserCell.m
//  BaiJie
//
//  Created by Andy Hurricane on 3/28/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import "AHRecommendUserCell.h"
#import "AHRecommendUser.h"
#import <UIImageView+WebCache.h>
@interface AHRecommendUserCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansLabel;


@end

@implementation AHRecommendUserCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setUser:(AHRecommendUser *)user{
    _user = user;
    
    self.nameLabel.text = user.screen_name;
    self.fansLabel.text = user.fans_count;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
