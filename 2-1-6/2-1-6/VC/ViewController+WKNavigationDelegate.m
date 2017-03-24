//
//  ViewController+VIewController_WKNavigationDelegate.m
//  2-1-6
//
//  Created by yuu ogasawara on 2017/03/21.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController (WKNavigationDelegate)

//読み込みを開始した時
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    if ([ReachabilityChecker checkReachability]){
        return;
    }else{
        [self whenOffline];
    }
}

//読み込みが失敗した時
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    //参考：http://nlogic.jp/?p=261
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Load failed"
                                                                             message:@"failed to load."
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    //アクションの設定
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:nil];
    [alertController addAction:okAction];
    
    //表示
    [self presentViewController:alertController
                       animated:YES
                     completion:nil];

}

@end
