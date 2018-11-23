//
//  IGCredentialsManager.m
//  DemoInstagramFeed
//
//  Created by Alsu Shigapova on 23/11/2018.
//  Copyright © 2018 Alsu Shigapova. All rights reserved.
//

#import "IGCredentialsManager.h"
#import <SimpleKeychain/SimpleKeychain.h>

@implementation IGCredentialsManager

NSString *const IGAccessTokenKeychainKey = @"ig-demo-feed-access-token";

+ (NSString *)getAccessToken {
    return [[A0SimpleKeychain keychain] stringForKey:IGAccessTokenKeychainKey];
}

+ (void)setAccessToken:(NSString *)accessToken {
    [[A0SimpleKeychain keychain] setString:accessToken forKey:IGAccessTokenKeychainKey];
}

+ (BOOL)hasAccessToken {
    return [IGCredentialsManager getAccessToken] != nil;
}

+ (void)clear {
    [[A0SimpleKeychain keychain] deleteEntryForKey:IGAccessTokenKeychainKey];
}

@end
