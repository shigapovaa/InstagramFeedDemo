//
//  IGPostViewController.h
//  DemoInstagramFeed
//
//  Created by Alsu Shigapova on 23/11/2018.
//  Copyright © 2018 Alsu Shigapova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IGPost.h"

NS_ASSUME_NONNULL_BEGIN

@interface IGPostViewController : UITableViewController

@property (nonatomic, strong) IGPost *post;

@end

NS_ASSUME_NONNULL_END
