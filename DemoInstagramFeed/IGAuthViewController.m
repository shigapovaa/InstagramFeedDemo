//
//  ViewController.m
//  DemoInstagramFeed
//
//  Created by Alsu Shigapova on 20/11/2018.
//  Copyright © 2018 Alsu Shigapova. All rights reserved.
//

#import "IGAuthViewController.h"
#import "IGApiService.h"

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
    NSArray<NSURLQueryItem *> *queryItems = [[NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:NO] queryItems];
    
    NSString *code = [[[queryItems
                        filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"name=%@", @"code"]]
                       firstObject] value];
    if (code != nil) {
        [self performAccessTokenRequestWithCode:code];
    } else {
        [self showAuthenticationErrorWithMessage:@"Couldn't get client code from redirect URI"];
    }
}

- (void)performAccessTokenRequestWithCode:(nonnull NSString *)code {
    [self.startOAuthButton setEnabled:NO];
    
    [IGApiService obtainAccessTokenUsingOAuthCode:code completion:^(NSError * _Nullable error, NSString * _Nullable accessToken) {
        [self.startOAuthButton setEnabled:YES];
        
        if (error != nil) {
            [self showAuthenticationErrorWithMessage:error.localizedDescription];
        } else {
            [self showAuthenticationErrorWithMessage:@"EZ ACCESS"];
        }
    }];
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
    [self.navigationController popToRootViewControllerAnimated:YES];
    [self showAuthenticationErrorWithMessage:error.localizedDescription];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSURL *url = navigationAction.request.URL;
    if (url != nil && [url.host isEqual: [[NSURL URLWithString:IGRedirectURI] host]]) {
        NSLog(@"handled url redirect!");
        [self handleFinalRedirectURL:url];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
    decisionHandler(WKNavigationActionPolicyAllow);
}

@end
