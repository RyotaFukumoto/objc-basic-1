//
//  ViewController.m
//  1-1-1
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
    
    boolProperty = YES;
    string = @"Yuu";
    integer = 35;
    
    typedef enum {
        Red,
        Green,
        Blue,
    }Color;
    number = @(Green); //プリミティブ型の変数をNSNumber型として扱うときに使うboxed expression
    
    NSLog(@"sex:%d name:%@ age:%ld color:%@",boolProperty,string,(long)integer,number);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
