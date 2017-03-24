//
//  ViewController.m
//  2-1-9
//
//  Created by yuu ogasawara on 2017/03/22.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "ViewController.h"



@interface ViewController ()
@property (nonnull) PickerBaseView *pickerBaseView;

@end

@implementation ViewController
#pragma mark Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildPickerView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark Event Handling
- (IBAction)labelTapped:(id)sender{
    [self showPickerBaseView:sender];
}

- (IBAction)viewTapped:(id)sender {
    [self hidePickerBaseView];
}

#pragma mark View Handling
-(void)buildPickerView{
    float height = self.view.bounds.size.height;
    float width = self.view.bounds.size.width;
    
    //アクセサリビューとピッカービューを乗せるビューの作成
    float pickerBaseViewHeight = PICKER_ACCESSORY_HEIGHT + PICKER_HEIGHT;
    
    self.pickerBaseView = [[PickerBaseView alloc] initWithFrame:CGRectMake(0,
                                                                           height,
                                                                           width,
                                                                           pickerBaseViewHeight)];
    self.pickerBaseView.delegate = self;
    
    [self.view addSubview:self.pickerBaseView];
}

- (void)showPickerBaseView:(id)sender
{
    [self.view bringSubviewToFront:self.pickerBaseView]; // 最前面に移動
    [UIView animateWithDuration:.20 animations:^{
        self.pickerBaseView.transform = CGAffineTransformMakeTranslation(0, -(PICKER_ACCESSORY_HEIGHT + PICKER_HEIGHT));
    }];
}

- (void)hidePickerBaseView
{
    [UIView animateWithDuration:.20 animations:^{
        self.pickerBaseView.transform = CGAffineTransformIdentity;
    }];
}

@end
