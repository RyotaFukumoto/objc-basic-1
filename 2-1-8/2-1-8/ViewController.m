//
//  ViewController.m
//  2-1-8
//
//  Created by yuu ogasawara on 2017/03/22.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.label.userInteractionEnabled = YES;

    self.roomList = @[@"ワンルーム",@"1K",@"1DK",@"1LDK",@"2K",@"2DK",@"2LDK",@"3K",@"3DK",@"3LDK",@"4K",@"4DK",@"4LDK",@"5K以上"];
    [self buildAreaPickerView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
