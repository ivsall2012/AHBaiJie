//
//  AHTopic.m
//  BaiJie
//
//  Created by Andy Hurricane on 4/1/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import "AHTopic.h"
#import <MJExtension.h>



@implementation AHTopic

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"smallImage" : @"image0",
             @"largeImage" : @"image1",
             @"mediumImage" : @"image2"
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
                    self.pictureFrame = CGRectMake(AHTopicCellMargin, _cellHeight, AHTopicCellMaxWidth, pictureH);
                    _cellHeight += pictureH;
                
                break;
            }
            case AHTopicTypeVideo:{
                
                break;
            }
            case AHTopicTypeVoice:{
                
                break;
            }
            case AHTopicTypeJoke:{

                break;
            }
        }
        _cellHeight += 35 + AHTopicCellMargin + AHTopicCellMargin;
        
        
        
    }
    return _cellHeight;
}
@end
