//
//  IGImage.h
//  DemoInstagramFeed
//
//  Created by Alsu Shigapova on 23/11/2018.
//  Copyright © 2018 Alsu Shigapova. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IGImage : JSONModel

@property (strong, nonatomic) NSString *url;
@property (nonatomic) NSInteger width;
@property (nonatomic) NSInteger height;

- (CGFloat)aspectRatio;

@end

NS_ASSUME_NONNULL_END
