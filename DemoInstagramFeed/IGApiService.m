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
    NSString *bodyString = [NSString stringWithFormat:@"client_id=%@&client_secret=%@&grant_type=%@&redirect_uri=%@&code=%@", IGClientID, IGClientSecret, @"authorization_code", IGRedirectURI, code];
    NSData *body = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
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
        
        NSString *accessToken = [responseBodyDict valueForKey:@"access_token"];
        
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

+ (void)getUserRecentPosts:(NSString *)pageURLString completion:(void (^)(NSError * _Nullable, IGMediaResponse * _Nullable))completionHandler {
    // obtain access token
    NSString *accessToken = [IGCredentialsManager getAccessToken];
    if (accessToken == nil) return;
    
    NSURL *igRecentMediaRequestURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@v1/users/self/media/recent/?access_token=%@", IGBaseURLString, accessToken]];
    
    // Configure HTTP Method
    NSMutableURLRequest *igRecentMediaRequest = [NSMutableURLRequest requestWithURL:igRecentMediaRequestURL];
    [igRecentMediaRequest setHTTPMethod:@"GET"];
    
    // perform the task
    [[[NSURLSession sharedSession] dataTaskWithRequest:igRecentMediaRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error != nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(error, nil);
            });
        }
        
        NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        
        NSError *parsingError;
        IGMediaResponse *mediaResponse = [[IGMediaResponse alloc] initWithData:data error:&error];
        
        if (mediaResponse != nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil, mediaResponse);
            });
        } else {
            NSError *finalError;
            
            if (parsingError != nil) {
                finalError = parsingError;
            } else {
                finalError = [NSError new];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(finalError, nil);
            });
        }
        
    }] resume];
}

@end
