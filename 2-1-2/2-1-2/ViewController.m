//
//  ViewController.m
//  2-1-2
//
//  Created by yuu ogasawara on 2017/03/21.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIImage* image = [UIImage imageNamed:@"cookie"];
//    image.layer.cornerRadius = 10.0f;
//    image.layer.masksToBounds = YES;
    self.imageView.image = image;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
