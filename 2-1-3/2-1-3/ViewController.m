//
//  ViewController.m
//  2-1-3
//
//  Created by yuu ogasawara on 2017/03/21.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property int previousImageNumber;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIImage* image = [UIImage imageNamed:@"1"];
    _imageView.image = image;
    _previousImageNumber = 1;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonTapped:(id)sender {
    //背景画像を１から５でランダムに変化する.ただし同じ画像が続かないようにする
    int min = 1;
    int max = 5;
    int rNumber = arc4random_uniform(max + 1 - min) + min;
    while (rNumber == _previousImageNumber) {
        rNumber = arc4random_uniform(max + 1 - min) + min;
    }
    NSLog(@"%d",rNumber);
    
    NSString *imageNumber = [NSString stringWithFormat:@"%d", rNumber];
    UIImage* image = [UIImage imageNamed:imageNumber];
    _imageView.image = image;
    _previousImageNumber = rNumber;
}

@end
