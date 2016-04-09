//
//  AHTopic.m
//  BaiJie
//
//  Created by Andy Hurricane on 4/1/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import "AHTopic.h"
#import <MJExtension.h>
#import "AHComment.h"
#import "AHUser.h"


@implementation AHTopic

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"smallImage" : @"image0",
             @"largeImage" : @"image1",
             @"mediumImage" : @"image2",
             @"ID":@"id",
             @"top_cm":@"top_cm[0]"
             };
}


-(CGFloat)cellHeight{
    if (!_cellHeight) {
        CGSize cellSize = [self.text boundingRectWithSize:CGSizeMake(AHTopicCellMaxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:AHTextFont} context:nil].size;
        _cellHeight = 66 + cellSize.height +AHTopicCellMargin;
        
        switch (self.type) {
            case AHTopicTypeAllKinds:{
                
                break;
            }
                
            case AHTopicTypePicture:{
                CGFloat pictureH = (AHTopicCellMaxWidth * self.height) / self.width;
                if (pictureH >= AHTopicCellMaxHeight) {
                    // click to see full picture
                    pictureH = AHTopicCellNomalHeight;
                    self.pictureTooBig = YES;
                }// else is within (0,AHTopicCellMaxHeight) ok to scroll several screen-width
                self.pictureFrame = CGRectMake(AHTopicCellMargin, _cellHeight, AHTopicCellMaxWidth, pictureH);
                _cellHeight += pictureH + AHTopicCellMargin;
                break;
            }
            case AHTopicTypeVideo:{
                CGFloat videoH = (AHTopicCellMaxWidth * self.height) / self.width;
                self.videoFrame = CGRectMake(AHTopicCellMargin, _cellHeight, AHTopicCellMaxWidth, videoH);
                _cellHeight += videoH;
                
                break;
            }
            case AHTopicTypeVoice:{
                CGFloat voiceH = (AHTopicCellMaxWidth * self.height) / self.width;
                self.voiceFrame = CGRectMake(AHTopicCellMargin, _cellHeight, AHTopicCellMaxWidth, voiceH);
                _cellHeight += voiceH;
                break;
            }
            case AHTopicTypeJoke:{
                break;
            }
        }
        if (self.top_cm) {
            AHUser *user = self.top_cm.user;
            self.hotCommentString = [NSString stringWithFormat:@"@%@: %@",user.username,self.top_cm.content];
            CGSize contentSize = [self.hotCommentString boundingRectWithSize:CGSizeMake(AHTopicCellMaxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:AHTextFont} context:nil].size;
            _cellHeight += AHTopicCellMargin + 20 + contentSize.height;
        }
        _cellHeight += 35 + AHTopicCellMargin;
        
        
        
    }
    return _cellHeight;
}
@end
