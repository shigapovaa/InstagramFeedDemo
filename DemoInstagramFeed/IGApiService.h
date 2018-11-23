//
//  IGApiService.h
//  DemoInstagramFeed
//
//  Created by Alsu Shigapova on 23/11/2018.
//  Copyright © 2018 Alsu Shigapova. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 A class that provides an interface for making requests to Instagram API.
 */
@interface IGApiService : NSObject

/**
 OAuth explicit flow continuation. This method should be called after you received
 an OAuth client code from Instagram web page.

 @param code OAuth client code.
 @param completionHandler A handler that is called on the main thread after the request was
 completed. Either an error or an access token will be passed.
 */
+ (void)obtainAccessTokenUsingOAuthCode:(NSString *)code completion:(void (^)(NSError* _Nullable error, NSString* _Nullable accessToken))completionHandler;

/**
 Retrieves current user's recent media. This method should only be called after
 user has authenticated in the app.

 @param pageURLString Optional URL for pagination purposes. If given, request will be called
 using this URL.
 @param completionHandler A handler that is called on the main thread upon request completion.
 */
+ (void)getUserRecentPosts:(nullable NSString *)pageURLString completion:(void (^)(NSError* _Nullable error, NSArray* _Nullable posts))completionHandler;

@end

NS_ASSUME_NONNULL_END
