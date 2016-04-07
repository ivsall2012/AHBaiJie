//
//  AHTopic.h
//  BaiJie
//
//  Created by Andy Hurricane on 4/1/16.
//  Copyright © 2016 Andy Hurricane. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface AHTopic : NSObject
@property (nonatomic,copy) NSString *text;
@property (nonatomic,copy) NSString *profile_image;
@property (nonatomic,copy) NSString *comment;
@property (nonatomic,copy) NSString *repost;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *cai;
@property (nonatomic,copy) NSString *ding;
@property (nonatomic,copy) NSString *created_at;
@property (nonatomic,assign) AHTopicType type;

@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;

@property (nonatomic,copy) NSString *image0; // small
@property (nonatomic,copy) NSString *image1; // big
@property (nonatomic,copy) NSString *image2; // medium
@property (nonatomic,copy) NSString *largeImage;
@property (nonatomic,copy) NSString *smallImage;
@property (nonatomic,copy) NSString *mediumImage;
@property (nonatomic,assign) CGRect pictureFrame;


@property (nonatomic,copy) NSString *videotime;
@property (nonatomic,copy) NSString *playcount;
@property (nonatomic, assign) CGRect videoFrame;


@property (nonatomic,copy) NSString *voicetime;
@property (nonatomic,assign) CGRect voiceFrame;


@property (nonatomic, assign,getter=isPictureTooBig) BOOL pictureTooBig;

@property (nonatomic, assign) CGFloat imageProgress;
@property (nonatomic,assign) CGFloat cellHeight;
@end
