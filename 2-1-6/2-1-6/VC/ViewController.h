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
-(void)whenOffline;
@end

@interface ViewController (WKNavigationDelegate)<WKNavigationDelegate>
@end
