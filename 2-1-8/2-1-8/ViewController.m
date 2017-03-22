//
//  ViewController.m
//  2-1-8
//
//  Created by yuu ogasawara on 2017/03/22.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.label.userInteractionEnabled = YES;

    [self buildAreaPickerView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
