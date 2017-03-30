//
//  ViewController.m
//  2-1-17
//
//  Created by yuu ogasawara on 2017/03/30.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

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

- (IBAction)buttonTapped:(UIButton *)sender {
    UIStoryboard* secondStoryBoard = [UIStoryboard storyboardWithName:@"Second"
                                                               bundle:nil];
    SecondViewController* secondVC = [secondStoryBoard instantiateViewControllerWithIdentifier:@"SecondViewController"];
    secondVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:secondVC
                       animated:true
                     completion:nil];
}

@end
