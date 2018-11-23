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

/**
 Saves access token into iOS Keychain.

 @param accessToken Access token to save.
 */
+ (void)setAccessToken:(NSString *)accessToken;

/**
 Retrieves access token from keychain.

 @return previously saved access token, if exists.
 */
+ (nullable NSString *)getAccessToken;

/**
 Returns whether or not the Keychain has access token in it.

 @return `YES` if there is access token in the Keychain, `NO` otherwise.
 */
+ (BOOL)hasAccessToken;

@end

NS_ASSUME_NONNULL_END
