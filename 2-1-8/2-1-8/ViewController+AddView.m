//
//  ViewController+AddView.m
//  2-1-8
//
//  Created by yuu ogasawara on 2017/03/22.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController (AddView)
//PickerView,Doneボタンを設定する
- (void)buildAreaPickerView{
    float height = self.view.bounds.size.height;
    float width = self.view.bounds.size.width;
    
    // 1. アクセサリビューとピッカービューを乗せるビューの作成
    float areaViewHeight = AREA_PICKER_ACCESSORY_HEIGHT + AREA_PICKER_HEIGHT;

    self.areaView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                             height,
                                                             width,
                                                             areaViewHeight)];
    [self.view addSubview:self.areaView];
    
    // 2-1. アクセサリビュー作成
    UIView *areaPickerAccessoryView =
    [[UIView alloc] initWithFrame:CGRectMake(0,
                                             0,
                                             width,
                                             AREA_PICKER_ACCESSORY_HEIGHT)];
    areaPickerAccessoryView.backgroundColor = [UIColor greenColor];
    
    // 2-2. 決定ボタン作成
    const float DONE_BUTTON_WEDTH = 80;
    UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    doneBtn.frame = CGRectMake(width - DONE_BUTTON_WEDTH,
                               4,
                               DONE_BUTTON_WEDTH,
                               36);
    doneBtn.backgroundColor = [UIColor whiteColor];
    [doneBtn setTitle:@"Done" forState:UIControlStateNormal];
    [doneBtn addTarget:self
                action:@selector(performAreaDoneButtonAction)
      forControlEvents:UIControlEventTouchUpInside];
    
    //2-3. 決定ボタンをアクセサリービューに乗せて、areaViewに加える
    [areaPickerAccessoryView addSubview:doneBtn];
    [self.areaView addSubview:areaPickerAccessoryView];
    
    // 3. ピッカー作成
    self.areaPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0,
                                                   AREA_PICKER_ACCESSORY_HEIGHT,
                                                   width,
                                                   AREA_PICKER_HEIGHT)];
    self.areaPickerView.backgroundColor = [UIColor whiteColor];
    self.areaPickerView.delegate = self;
    self.areaPickerView.dataSource = self;
    [self.areaPickerView selectRow:2 inComponent:0 animated:NO]; // 初期値設定
    [self.areaView addSubview:self.areaPickerView];
}

- (void)performAreaDoneButtonAction
{
    NSInteger row = [self.areaPickerView selectedRowInComponent:0];
    self.label.text = self.roomList[row];
    [self hideAreaView];
}

- (void)hideAreaView
{
    [UIView animateWithDuration:.20 animations:^{
        self.areaView.transform = CGAffineTransformIdentity;
    }];
    //self.overlayView.frame = CGRectZero;
}

@end
