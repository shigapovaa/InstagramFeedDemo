//
//  IGMediaResponse.h
//  DemoInstagramFeed
//
//  Created by Alsu Shigapova on 23/11/2018.
//  Copyright © 2018 Alsu Shigapova. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "IGPost.h"
#import "IGPaginationInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface IGMediaResponse : JSONModel

@property (strong, nonatomic) NSArray<IGPost *> <IGPost> *data;
@property (strong, nonatomic) IGPaginationInfo *pagination;

@end

NS_ASSUME_NONNULL_END
