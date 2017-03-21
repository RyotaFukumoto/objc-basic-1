//
//  ViewController.h
//  2-1-6
//
//  Created by yuu ogasawara on 2017/03/21.
//  Copyright © 2017年 stv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "ReachabilityChecker.h"

@interface ViewController : UIViewController

- (IBAction)tappedReloadButton:(id)sender;
-(void)whenOffline;

@property (strong, nonatomic) WKWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *reloadButton;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;

@end

@interface ViewController (WKNavigationDelegate)<WKNavigationDelegate>
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation;
@end
