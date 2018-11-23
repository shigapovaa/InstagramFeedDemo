//
//  WKWebViewController.m
//  DemoInstagramFeed
//
//  Created by Alsu Shigapova on 20/11/2018.
//  Copyright © 2018 Alsu Shigapova. All rights reserved.
//

#import "WKWebViewController.h"

@interface WKWebViewController ()

@end

@implementation WKWebViewController

- (void)loadView {
    [self setView: [WKWebView new]];
}

-(WKWebView*)webView {
    return (WKWebView *)self.view;
}

@end
