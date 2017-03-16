//
//  ViewController.m
//  1-1-2
//
//  Created by yogasawara@stv on 2017/03/16.
//  Copyright © 2017年 yogasawara@stv. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"A week is composed from");
    
    array = @[@"Sunday",@"Monday", @"Tuesday",@"Wednesday",@"Thursday",@"Friday",@"Saturday"];
    for (int i = 0; i < array.count; i++) {
        NSLog(@"%@", array[i]);
    }
    
    dictionary = @{@"name":@"yuu", @"address":@"Tokyo"};
    NSLog(@"your name is %@", dictionary[@"name"]);
    NSLog(@"your adress is %@", dictionary[@"address"]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
