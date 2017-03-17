//
//  ViewController.m
//  1-1-5
//
//  Created by yuu ogasawara on 2017/03/17.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    Account *michishige = [[Account alloc] initWithName:@"Michishige"
                                                    age:28
                                                    sex:@"女性"
                                       favoriteLanguage:@"Objective C"];
    [michishige goToIntern];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
