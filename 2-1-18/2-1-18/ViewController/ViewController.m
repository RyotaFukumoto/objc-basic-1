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

#pragma mark View Transition
- (IBAction)buttonTapped:(UIButton *)sender {
    UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"Main"
                                                               bundle:nil];
    DetailViewController* detailVC = [storyBoard instantiateViewControllerWithIdentifier:kDetailViewControllerIdentifier];
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
