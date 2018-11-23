//
//  WKWebViewController.h
//  DemoInstagramFeed
//
//  Created by Alsu Shigapova on 20/11/2018.
//  Copyright © 2018 Alsu Shigapova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 A view controller for presenting a WKWebView.
 */
@interface WKWebViewController : UIViewController

/**
 Getter for controller's WKWebView.

 @return WKWebView instance, which is actually a root view of the controller.
 */
- (nonnull WKWebView*)webView;

@end

NS_ASSUME_NONNULL_END
