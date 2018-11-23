//
//  IGPaginationInfo.h
//  DemoInstagramFeed
//
//  Created by Alsu Shigapova on 23/11/2018.
//  Copyright © 2018 Alsu Shigapova. All rights reserved.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface IGPaginationInfo : JSONModel

@property (strong, nonatomic) NSString <Optional> * _Nullable nextUrl;

@end

NS_ASSUME_NONNULL_END
