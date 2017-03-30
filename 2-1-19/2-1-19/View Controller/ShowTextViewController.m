//
//  ShowTextViewController.m
//  2-1-19
//
//  Created by yuu ogasawara on 2017/03/30.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "ShowTextViewController.h"

@interface ShowTextViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@end

@implementation ShowTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.label.text = self.text;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
