//
//  ViewController.m
//  2-1-6
//
//  Created by yuu ogasawara on 2017/03/21.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize webView;
@synthesize toolBar;

static NSString * const InitialURL = @"https://google.com";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.navigationDelegate = self;
    
    //WKWebViewインスタンスのプロパティの変更を監視する
    [self.webView addObserver:self forKeyPath:@"loading" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:@"canGoForward" options:NSKeyValueObservingOptionNew context:nil];
    
    // 初回画面表示時にIntialURLで指定した Web ページを読み込む
    if ([ReachabilityChecker checkReachability]){
        NSURL *url = [NSURL URLWithString:InitialURL];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
    }else{
        [self whenOffline];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [self.webView removeObserver:self forKeyPath:@"loading"];
    [self.webView removeObserver:self forKeyPath:@"canGoBack"];
    [self.webView removeObserver:self forKeyPath:@"canGoForward"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"loading"]) {
        // loadingが変更されたら、ステータスバーのインジケーターの表示・非表示を切り替える
        [UIApplication sharedApplication].networkActivityIndicatorVisible = self.webView.loading;
        
        // リロードボタンと読み込み停止ボタンの有効・無効を切り替える
        self.reloadButton.enabled = !self.webView.loading;
        
    }else if ([keyPath isEqualToString:@"canGoBack"]) {
        // canGoBackが変更されたら、「＜」ボタンの有効・無効を切り替える
        self.backButton.enabled = self.webView.canGoBack;
        
    } else if ([keyPath isEqualToString:@"canGoForward"]) {
        // canGoForwardが変更されたら、「＞」ボタンの有効・無効を切り替える
        self.forwardButton.enabled = self.webView.canGoForward;
    }
}

- (void)loadView
{
    [super loadView];
    
    // WKWebView インスタンスの生成
    self.webView = [WKWebView new];
    
    //ステータスバー、ツールバーとビューが被らないようにする
    //http://kzy52.com/entry/2015/02/20/000838
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    CGFloat toolBarHeight = toolBar.frame.size.height;

    CGRect rect = CGRectMake(0, statusBarHeight, width, height - (statusBarHeight + toolBarHeight));
    self.webView.frame = rect;
    
    //端末の向きが変わっても表示が崩れないようにする
    webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    
    // フリップでの戻る・進むを有効にする
    self.webView.allowsBackForwardNavigationGestures = YES;
    
    // WKWebView インスタンスを画面に配置する
    [self.view insertSubview:self.webView atIndex:0];
}

-(void)viewWillLayoutSubviews{
    //Landscapeだと表示が崩れてしまうので再設定する
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    CGRect rect = CGRectMake(0, statusBarHeight, width, height);
    self.webView.frame = rect;
}

- (IBAction)tappedReloadButton:(id)sender {
    if ([ReachabilityChecker checkReachability]){
        [self.webView reload];
    }else{
        [self whenOffline];
    }
}

- (IBAction)tappedBackButton:(id)sender {
    if ([ReachabilityChecker checkReachability]){
        if ([self.webView canGoBack]){
            [self.webView goBack];
        }
    }else{
        [self whenOffline];
    }
}

- (IBAction)tappedForwardButton:(id)sender {
    if ([ReachabilityChecker checkReachability]){
        if ([self.webView canGoForward]) {
            [self.webView goForward];
        }
    }else{
        [self whenOffline];
    }
}

-(void)whenOffline{
    //参考：http://nlogic.jp/?p=261
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Offline"
                                                                             message:@"You are now in offline."
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
