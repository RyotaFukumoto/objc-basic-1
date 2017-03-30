//
//  SecondViewController.m
//  2-1-17
//
//  Created by yuu ogasawara on 2017/03/30.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark transition
- (IBAction)buttonTapped:(UIButton *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
