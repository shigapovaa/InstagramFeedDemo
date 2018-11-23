//
//  IGUser.h
//  DemoInstagramFeed
//
//  Created by Alsu Shigapova on 23/11/2018.
//  Copyright © 2018 Alsu Shigapova. All rights reserved.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface IGUser : JSONModel

@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *profilePicture;

@end

NS_ASSUME_NONNULL_END
