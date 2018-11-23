//
//  IGUser.m
//  DemoInstagramFeed
//
//  Created by Bulat Khabirov on 23/11/2018.
//  Copyright © 2018 Alsu Shigapova. All rights reserved.
//

#import "IGUser.h"

@implementation IGUser

@synthesize username = _username;
@synthesize profilePicture = _profilePicture;

+ (JSONKeyMapper *)keyMapper {
    return [JSONKeyMapper mapperForSnakeCase];
}

@end
