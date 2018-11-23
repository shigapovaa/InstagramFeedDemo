//
//  IGApiService.m
//  DemoInstagramFeed
//
//  Created by Alsu Shigapova on 23/11/2018.
//  Copyright © 2018 Alsu Shigapova. All rights reserved.
//

#import "IGApiService.h"
#import "Constants.h"
#import "IGCredentialsManager.h"

@implementation IGApiService

+ (void)obtainAccessTokenUsingOAuthCode:(NSString *)code completion:(void (^)(NSError * _Nullable, NSString * _Nullable))completionHandler {
    NSURL *igAccessTokenRequestURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@oauth/access_token", IGBaseURLString]];
    
    // Configure HTTP Method
    NSMutableURLRequest *igAccessTokenRequest = [NSMutableURLRequest requestWithURL:igAccessTokenRequestURL];
    [igAccessTokenRequest setHTTPMethod:@"POST"];
    
    // Configure request body
    NSDictionary *bodyDict = @{
                               @"client_secret": IGClientSecret,
                               @"grant_type": @"authorization_code",
                               @"redirect_uri": IGRedirectURI,
                               @"code": code
                               };
    NSData *body = [NSJSONSerialization dataWithJSONObject:bodyDict options:0 error:nil];
    [igAccessTokenRequest setHTTPBody:body];
    
    // perform the task
    [[[NSURLSession sharedSession] dataTaskWithRequest:igAccessTokenRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // pass network error immediately, if one occurred
        if (error != nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(error, nil);
            });
            return;
        }
        
        // attempt to parse JSON response
        NSError *parsingError;
        NSDictionary *responseBodyDict = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:data options:0 error:&parsingError];
        
        if (parsingError != nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(parsingError, nil);
            });
            return;
        }
        
        NSString *accessToken = [[responseBodyDict valueForKey:@"access_token"] stringValue];
        
        // pass parsed response
        dispatch_async(dispatch_get_main_queue(), ^{
            if (accessToken != nil) {
                // save access token into keychain
                [IGCredentialsManager setAccessToken:accessToken];
                completionHandler(nil, accessToken);
            } else {
                completionHandler([NSError new], nil);
            }
        });
    }] resume];
}

@end
