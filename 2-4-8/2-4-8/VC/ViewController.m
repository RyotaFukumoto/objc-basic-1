//
//  ViewController.m
//  2-4-8
//
//  Created by yuu ogasawara on 2017/04/17.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "ViewController.h"
#import "PostInstagram.h"

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

- (void)viewDidAppear:(BOOL)animated{

    if ([PostInstagram canInstagramAppOpen]) {
        
        UIImage *image = [UIImage imageNamed:@"cookie"]; // <- 投稿したい画像を準備しておく
        
        PostInstagram *instagramViewController = [[PostInstagram alloc] init];
        [instagramViewController setImage:image];
        [self.view addSubview:instagramViewController.view];
        [self addChildViewController:instagramViewController];
        
    } else {
        // Instagramがインストールされていない
    }
}
@end
