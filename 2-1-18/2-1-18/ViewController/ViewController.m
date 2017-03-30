//
//  ViewController.m
//  2-1-18
//
//  Created by yuu ogasawara on 2017/03/30.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "ViewController.h"
#import "Const.h"
#import "DetailViewController.h"

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

#pragma mark Subview Event
- (IBAction)buttonTapped:(UIButton *)sender {
    [self performSegueWithIdentifier:kShowSegueIdentifier
                              sender:nil];
}

@end
