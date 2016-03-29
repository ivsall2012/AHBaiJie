//
//  AHRecommendCategoryCell.m
//  BaiJie
//
//  Created by Andy Hurricane on 3/28/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import "AHRecommendCategoryCell.h"
#import "AHRecommendCategory.h"
@interface AHRecommendCategoryCell()
@property (weak, nonatomic) IBOutlet UIView *separator;
@property (weak, nonatomic) IBOutlet UIView *sideBar;

@end


@implementation AHRecommendCategoryCell

- (void)awakeFromNib {
    self.backgroundColor = AHGlobelViewColor;
}
-(void)setCategory:(AHRecommendCategory *)category{
    _category = category;
    
    self.textLabel.text = category.name;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.sideBar.hidden = !selected;
    self.textLabel.textColor = selected?self.sideBar.backgroundColor:AHColor(78, 78, 78);
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.textLabel.Y = 2;
    // remember to use self.contentView                here 2*..y to make symmetric
    self.textLabel.height = self.contentView.height - 2*self.textLabel.Y;
}
@end
