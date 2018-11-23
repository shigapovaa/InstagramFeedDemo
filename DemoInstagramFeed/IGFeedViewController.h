//
//  IGFeedViewController.h
//  DemoInstagramFeed
//
//  Created by Alsu Shigapova on 23/11/2018.
//  Copyright © 2018 Alsu Shigapova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IGApiService.h"
#import "IGMediaResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface IGFeedViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray<IGPost *> *posts;
@property (nonatomic) BOOL isLoadingData;

- (void)loadFeedData;
- (void)showLoadingErrorWithMessage:(nonnull NSString*)message;

@end

NS_ASSUME_NONNULL_END
