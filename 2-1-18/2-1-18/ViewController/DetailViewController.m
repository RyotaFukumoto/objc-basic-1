//
//  DetailViewController.m
//  2-1-18
//
//  Created by yuu ogasawara on 2017/03/30.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "DetailViewController.h"
#import "CalendarHandler.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    self.label.text = [[[CalendarHandler alloc] init] timeInfomationString];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
