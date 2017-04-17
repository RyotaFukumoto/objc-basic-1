//
//  ViewController.m
//  2-4-6
//
//  Created by yuu ogasawara on 2017/04/17.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "ViewController.h"
#import <Social/Social.h>

@interface ViewController ()

@end

@implementation ViewController

#pragma mark Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Post SNS
- (IBAction)buttonTapped:(UIButton *)sender
{
    // ServiceType を指定して SLComposeViewController を作成
    SLComposeViewController *composeViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    
    //画像を追加
    [composeViewController addImage:[UIImage imageNamed:@"image"]];

    // 処理完了時に実行される completionHandler を設定
    composeViewController.completionHandler = ^(SLComposeViewControllerResult result) {
        if (result == SLComposeViewControllerResultCancelled) {
            NSLog(@"Cancelled");
        } else {
            NSLog(@"Done");
        }
    };
    
    // SLComposeViewController を表示する
    [self presentViewController:composeViewController
                       animated:YES
                     completion:nil];
}

@end
