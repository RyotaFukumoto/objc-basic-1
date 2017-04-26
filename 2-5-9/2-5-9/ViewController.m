//
//  ViewController.m
//  2-5-9
//
//  Created by yogasawara@stv on 2017/04/24.
//  Copyright © 2017年 smart tech ventures. All rights reserved.
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

#pragma mark Push Notification 
-(void)alertPushNotifications:(NSString*)bodyMessage{
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Alert"
                                                                             message:bodyMessage
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alertController
                       animated:YES
                     completion:^(void){
                         [self performSelector:@selector(dismissAlert)
                                    withObject:nil
                                    afterDelay:5.0];
                     }];
}

-(void)dismissAlert{
    [self dismissViewControllerAnimated:NO
                             completion:nil];
}
@end
