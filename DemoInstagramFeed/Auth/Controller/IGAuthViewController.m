//
//  ViewController.m
//  DemoInstagramFeed
//
//  Created by Alsu Shigapova on 20/11/2018.
//  Copyright © 2018 Alsu Shigapova. All rights reserved.
//

#import "IGAuthViewController.h"

@interface IGAuthViewController ()

@end

@implementation IGAuthViewController

@synthesize startOAuthButton = _startOAuthButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

// MARK: - User actions
- (IBAction)didTapStartOAuthButton:(UIButton *)sender {
    [self showOAuthWebViewController];
}

// MARK: - Data
- (void)handleFinalRedirectURL:(NSURL *)url {
    
}

// MARK: - Routing
/**
 Convenience method for presenting an UIAlertController representing an error
 with a given message and an OK button.
 
 @param message A message to show to the user.
 */
- (void)showAuthenticationErrorWithMessage:(nonnull NSString*)message {
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:@"Authentication Error"
                                message:message
                                preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                              style:UIAlertActionStyleCancel
                                            handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showOAuthWebViewController {
    WKWebViewController *webController = [WKWebViewController new];
    webController.webView.navigationDelegate = self;
    [webController setTitle:@"Instagram OAuth"];
    
    // assemble oauth request
    NSURL *oauthURL = [NSURL URLWithString:
                       [NSString stringWithFormat: @"%@oauth/authorize/?client_id=%@&redirect_uri=%@&response_type=code",
                        IGBaseURLString, IGClientID, IGRedirectURI]];
    NSURLRequest *request = [NSURLRequest requestWithURL:oauthURL];
    [webController.webView loadRequest:request];
    
    [self.navigationController pushViewController:webController animated:YES];
}

// MARK: - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    // dismiss currently presented WKWebViewController instance and show the error to the user
    [self dismissViewControllerAnimated:YES completion:^{
        [self showAuthenticationErrorWithMessage:error.localizedDescription];
    }];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSLog(@"%@", navigationAction.request.URL);
    decisionHandler(WKNavigationActionPolicyAllow);
}

@end
