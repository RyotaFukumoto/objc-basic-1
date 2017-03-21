//
//  ViewController.m
//  2-1-4
//
//  Created by yuu ogasawara on 2017/03/21.
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

- (IBAction)buttonTapped:(id)sender {
    //参考：http://nlogic.jp/?p=261
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert Title"
                                                                             message:@"show message"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    //アクションの設定
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction *action) {
                                                       NSLog(@"clicked Button title: %@", action.title);
                                                   }];
    [alertController addAction:okAction];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction *action) {
                                                       NSLog(@"clicked Button title: %@", action.title);
                                                   }];
    [alertController addAction:cancelAction];
    
    //表示
    [self presentViewController:alertController
                       animated:YES
                     completion:nil];
}

@end
