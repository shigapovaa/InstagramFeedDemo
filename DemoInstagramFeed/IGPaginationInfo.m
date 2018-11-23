//
//  IGPaginationInfo.m
//  DemoInstagramFeed
//
//  Created by Alsu Shigapova on 23/11/2018.
//  Copyright © 2018 Alsu Shigapova. All rights reserved.
//

#import "IGPaginationInfo.h"

@implementation IGPaginationInfo

@synthesize nextUrl = _nextUrl;

+ (JSONKeyMapper *)keyMapper {
    return [JSONKeyMapper mapperForSnakeCase];
}

@end
