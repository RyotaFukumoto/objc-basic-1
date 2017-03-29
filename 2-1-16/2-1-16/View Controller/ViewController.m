//
//  ViewController.m
//  2-1-16
//
//  Created by yuu ogasawara on 2017/03/29.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
}
@property (weak, nonatomic) IBOutlet UILabel *pageNumberLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //ページ番号の設定
    NSMutableString *pageNumberLabelText = [NSMutableString string];
    [pageNumberLabelText appendString:[NSString stringWithFormat:@"%zd",self.pageNumber]];
    [pageNumberLabelText appendString:@"/"];
    [pageNumberLabelText appendString:[NSString stringWithFormat:@"%d",kMaxPageNumber]];
    self.pageNumberLabel.text = [NSString stringWithString:pageNumberLabelText];
    
    //背景色の設定:ページ番号が大きくなるに連れて、緑が濃くなる
    double a = 1.0 - kGreenInitialNumber;
    double b = kMaxPageNumber - kMinPageNumber;
    NSInteger tempNum = self.pageNumber - kMinPageNumber;
    double c = tempNum;
    double greenParameter = (a/b) * c + (double)kGreenInitialNumber;
    self.view.backgroundColor = [UIColor colorWithRed:kRedInitialNumber
                                                green:greenParameter
                                                 blue:kBlueInitialNumber
                                                alpha:kAlphaValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
