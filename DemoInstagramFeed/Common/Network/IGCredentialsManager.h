//
//  IGCredentialsManager.h
//  DemoInstagramFeed
//
//  Created by Alsu Shigapova on 23/11/2018.
//  Copyright © 2018 Alsu Shigapova. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 A class that manages Instagram API Access token.
 Provides an interface for saving and obtaining the token from iOS Keychain.
 */
@interface IGCredentialsManager : NSObject

FOUNDATION_EXPORT NSString *const IGAccessTokenKeychainKey;

+ (void)setAccessToken:(NSString *)accessToken;
+ (nullable NSString *)getAccessToken;

@end

NS_ASSUME_NONNULL_END
