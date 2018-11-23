//
//  IGImage.m
//  DemoInstagramFeed
//
//  Created by Alsu Shigapova on 23/11/2018.
//  Copyright © 2018 Alsu Shigapova. All rights reserved.
//

#import "IGImage.h"

@implementation IGImage

@synthesize width = _width;
@synthesize height = _height;
@synthesize url = _url;

- (CGFloat)aspectRatio {
    return (CGFloat)self.width / (CGFloat)self.height;
}

@end
