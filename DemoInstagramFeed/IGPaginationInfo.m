//
//  IGPaginationInfo.m
//  DemoInstagramFeed
//
//  Created by Bulat Khabirov on 23/11/2018.
//  Copyright © 2018 Alsu Shigapova. All rights reserved.
//

#import "IGPaginationInfo.h"

@implementation IGPaginationInfo

+ (JSONKeyMapper *)keyMapper {
    return [JSONKeyMapper mapperForSnakeCase];
}

@end
