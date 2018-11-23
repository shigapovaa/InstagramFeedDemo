//
//  IGFeedViewController.m
//  DemoInstagramFeed
//
//  Created by Bulat Khabirov on 23/11/2018.
//  Copyright © 2018 Alsu Shigapova. All rights reserved.
//

#import "IGFeedViewController.h"
#import "IGCredentialsManager.h"

@interface IGFeedViewController ()

@end

@implementation IGFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self showAuthScreenIfNeeded];
}

#pragma mark - Routing
- (BOOL)showAuthScreenIfNeeded {
    if ([IGCredentialsManager hasAccessToken]) {
        return NO;
    } else {
        [self performSegueWithIdentifier:@"auth" sender:self];
        return YES;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

@end
