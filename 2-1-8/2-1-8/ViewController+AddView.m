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
- (void)buildPickerView{
    float height = self.view.bounds.size.height;
    float width = self.view.bounds.size.width;
    
    // 1. アクセサリビューとピッカービューを乗せるビューの作成
    float pickerBaseViewHeight = PICKER_ACCESSORY_HEIGHT + PICKER_HEIGHT;

    self.pickerBaseView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                             height,
                                                             width,
                                                             pickerBaseViewHeight)];
    [self.view addSubview:self.pickerBaseView];
    
    // 2-1. アクセサリビュー作成
    UIView *pickerAccessoryView =
    [[UIView alloc] initWithFrame:CGRectMake(0,
                                             0,
                                             width,
                                             PICKER_ACCESSORY_HEIGHT)];
    
    pickerAccessoryView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    // 2-2. 決定ボタン作成
    const float DONE_BUTTON_WEDTH = 80;
    UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    doneBtn.frame = CGRectMake(width - DONE_BUTTON_WEDTH,
                               4,
                               DONE_BUTTON_WEDTH,
                               36);
    doneBtn.backgroundColor = [UIColor whiteColor];
    doneBtn.tintColor = [UIColor blueColor];
    [doneBtn setTitle:@"Done" forState:UIControlStateNormal];
    [doneBtn addTarget:self
                action:@selector(performDoneButtonAction)
      forControlEvents:UIControlEventTouchUpInside];
    
    //2-3. 決定ボタンをアクセサリービューに乗せて、pickerBaseViewに加える
    [pickerAccessoryView addSubview:doneBtn];
    [self.pickerBaseView addSubview:pickerAccessoryView];
    
    // 3. ピッカー作成
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0,
                                                   PICKER_ACCESSORY_HEIGHT,
                                                   width,
                                                   PICKER_HEIGHT)];
    self.pickerView.backgroundColor = [UIColor whiteColor];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    [self.pickerView selectRow:2 inComponent:0 animated:NO]; // 初期値設定
    [self.pickerBaseView addSubview:self.pickerView];
}

- (void)performDoneButtonAction
{
    NSInteger row = [self.pickerView selectedRowInComponent:0];
    self.label.text = self.roomList[row];
    [self hidePickerBaseView];
}

- (void)hidePickerBaseView
{
    [UIView animateWithDuration:.20 animations:^{
        self.pickerBaseView.transform = CGAffineTransformIdentity;
    }];
    //self.overlayView.frame = CGRectZero;
}

@end
