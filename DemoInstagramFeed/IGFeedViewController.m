//
//  IGFeedViewController.m
//  DemoInstagramFeed
//
//  Created by Alsu Shigapova on 23/11/2018.
//  Copyright © 2018 Alsu Shigapova. All rights reserved.
//

#import "IGFeedViewController.h"
#import "IGCredentialsManager.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "IGPostTableViewCell.h"

@interface IGFeedViewController ()

@end

@implementation IGFeedViewController

@synthesize posts = _posts;
@synthesize isLoadingData = _isLoadingData;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTableView];
    self.isLoadingData = false;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (![self showAuthScreenIfNeeded] && (self.posts == nil || [self.posts count] == 0)) {
        [self loadFeedData];
    }
}

- (void)configureTableView {
    [self.tableView registerNib:[UINib nibWithNibName:@"IGPostTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
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

- (void)showLoadingErrorWithMessage:(nonnull NSString*)message {
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:@"Error while loading data"
                                message:message
                                preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                              style:UIAlertActionStyleCancel
                                            handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Data
- (void)loadFeedData {
    if (self.isLoadingData) return;
    
    self.isLoadingData = true;
    
    [IGApiService getUserRecentPosts:nil completion:^(NSError * _Nullable error, IGMediaResponse * _Nullable response) {
        self.isLoadingData = false;
        
        if (error != nil) {
            [self showLoadingErrorWithMessage:error.localizedDescription];
        } else {
            self.posts = [[NSMutableArray alloc] initWithArray:response.data];
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.posts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IGPostTableViewCell *cell = (IGPostTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.contentImageView.image = nil;
    cell.authorNameLabel.text = @"";
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    IGPost *post = [self.posts objectAtIndex:indexPath.row];
    CGFloat ratio = [post.image aspectRatio];
    
    CGFloat imageHeight = tableView.frame.size.width / ratio;
    
    return imageHeight + 44 + 30;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    IGPostTableViewCell *postCell = (IGPostTableViewCell *)cell;
    IGPost *post = [self.posts objectAtIndex:indexPath.row];
    
    postCell.authorNameLabel.text = post.user.username;
    [postCell.authorAvatarImageView sd_setImageWithURL:[NSURL URLWithString:post.user.profilePicture]];
    [postCell.contentImageView sd_setImageWithURL:[NSURL URLWithString:post.image.url]];
    postCell.likesCountLabel.text = [NSString stringWithFormat:@"%ld", post.likesCount];
}


@end
