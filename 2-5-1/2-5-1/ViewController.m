//
//  ViewController.m
//  2-5-1
//
//  Created by yuu ogasawara on 2017/04/18.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 メール作成ボタンが押されたら呼ばれるメソッド

 @param sender  Storyboardで設定したボタン
 */
- (IBAction)composeButtonTapped:(UIButton *)sender {
    //メールを送信できるかチェック
    if (![MFMailComposeViewController canSendMail]) {
        NSLog(@"Mail services are not available.");
        return;
    }
    
    MFMailComposeViewController* mailViewController = [[MFMailComposeViewController alloc] init];
    
    mailViewController.mailComposeDelegate = self;
    [mailViewController setSubject:@"アプリからメール送信"];
    [mailViewController setMessageBody:@"ここに本文を入力してください。"
                                isHTML:NO];
    [self presentViewController:mailViewController
                       animated:YES
                     completion:nil];
}

#pragma mark MFMailComposeViewControllerDelegate

/**
 デリゲートメソッド。メール作成画面でボタンが押されたら呼ばれる。画面遷移の処理をここに実装する。
 */
- (void) mailComposeController:(MFMailComposeViewController *)controller
           didFinishWithResult:(MFMailComposeResult)result
                         error:(NSError *)error{

    switch (result) {
        case MFMailComposeResultCancelled:{
            NSLog(@"Email Send Cancelled");
            break;
        }
        case MFMailComposeResultSaved:{
            NSLog(@"Email Saved as a Draft");
            break;
        }
        case MFMailComposeResultSent:{
            NSLog(@"Email Sent Successfully");
            break;
        }
        case MFMailComposeResultFailed:{
            NSLog(@"Email send Failed");
            break;
        }
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}
@end
