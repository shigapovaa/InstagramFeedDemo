//
//  ViewController.h
//  DemoInstagramFeed
//
//  Created by Alsu Shigapova on 20/11/2018.
//  Copyright © 2018 Alsu Shigapova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKWebViewController.h"
#import "Constants.h"

NS_ASSUME_NONNULL_BEGIN

@interface IGAuthViewController : UIViewController<WKNavigationDelegate>

@property (weak, nonatomic) IBOutlet UIButton* startOAuthButton;

- (IBAction)didTapStartOAuthButton:(UIButton *)sender;
- (void)performAccessTokenRequestWithCode:(nonnull NSString *)code;
- (void)handleFinalRedirectURL:(NSURL *)url;
- (void)showAuthenticationErrorWithMessage:(nonnull NSString*)message;
- (void)showOAuthWebViewController;

@end

NS_ASSUME_NONNULL_END
