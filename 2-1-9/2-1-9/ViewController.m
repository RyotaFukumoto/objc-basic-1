//
//  ViewController.m
//  2-1-9
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

    self.label.userInteractionEnabled = YES;

    [self buildPickerView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)buildPickerView{
    float height = self.view.bounds.size.height;
    float width = self.view.bounds.size.width;
    
    // 1. アクセサリビューとピッカービューを乗せるビューの作成
    float pickerBaseViewHeight = PICKER_ACCESSORY_HEIGHT + PICKER_HEIGHT;
    
    self.pickerBaseView = [[PickerBaseView alloc] initWithFrame:CGRectMake(0,
                                                                   height,
                                                                   width,
                                                                   pickerBaseViewHeight)];
    [self.view addSubview:self.pickerBaseView];
}

- (IBAction)labelTapped:(id)sender{
    [self showPickerBaseView:sender];
}

- (void)showPickerBaseView:(id)sender
{
    [self.view bringSubviewToFront:self.pickerBaseView]; // 最前面に移動
    [UIView animateWithDuration:.20 animations:^{
        self.pickerBaseView.transform = CGAffineTransformMakeTranslation(0, -(PICKER_ACCESSORY_HEIGHT + PICKER_HEIGHT));
    }];
}

@end
