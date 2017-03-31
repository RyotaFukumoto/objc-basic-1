//
//  LoadViewController.m
//  2-3-1
//
//  Created by yuu ogasawara on 2017/03/31.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "LoadViewController.h"
#import "Const.h"
#import "UserDefaultsManager.h"

@interface LoadViewController ()
@property (weak, nonatomic) IBOutlet UILabel *intLabel;
@property (weak, nonatomic) IBOutlet UILabel *doubleLabel;
@property (weak, nonatomic) IBOutlet UILabel *stringLabel;
@end

@implementation LoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self displayData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)displayData{
    SaveData* data = [[[UserDefaultsManager alloc] init] loadData];
    
    if (data == nil) {
        return;
    }
    
    self.intLabel.text = [NSString stringWithFormat:@"%zd",data.integer];
    self.doubleLabel.text = [NSString stringWithFormat:@"%f",data.doubleNumber];
    self.stringLabel.text = data.string;
}

@end
