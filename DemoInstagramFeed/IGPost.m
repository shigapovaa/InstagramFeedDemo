//
//  IGPost.m
//  DemoInstagramFeed
//
//  Created by Bulat Khabirov on 23/11/2018.
//  Copyright © 2018 Alsu Shigapova. All rights reserved.
//

#import "IGPost.h"

@implementation IGPost

@synthesize mediaID = _mediaID;
@synthesize captionText = _captionText;
@synthesize image = _image;
@synthesize likesCount = _likesCount;
@synthesize user = _user;

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc]
            initWithModelToJSONDictionary:@{
                                          @"mediaID": @"id",
                                          @"image": @"images.standard_resolution",
                                          @"likesCount": @"likes.count",
                                          @"user": @"user",
                                          @"captionText": @"caption.text"
                                        }];
}

@end
