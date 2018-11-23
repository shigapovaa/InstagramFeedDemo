//
//  IGPost.h
//  DemoInstagramFeed
//
//  Created by Alsu Shigapova on 23/11/2018.
//  Copyright © 2018 Alsu Shigapova. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "IGUser.h"
#import "IGImage.h"

NS_ASSUME_NONNULL_BEGIN
@protocol IGPost;

@interface IGPost : JSONModel

@property (strong, nonatomic) IGUser  *user;
@property (strong, nonatomic) NSString *mediaID;
@property (strong, nonatomic) IGImage *image;
@property (nonatomic) NSInteger likesCount;
@property (strong, nonatomic) NSString <Optional> * _Nullable captionText;

@end

NS_ASSUME_NONNULL_END
