//
//  ViewController+AddView.m
//  2-1-8
//
//  Created by yuu ogasawara on 2017/03/22.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController (AddView)
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
}

- (void)performAreaDoneButtonAction
{
    //NSInteger row = [self.areaPickerView selectedRowInComponent:0];
    //NSLog(@"areaCode:%@, areaName:%@", self.areaList[row][0], self.areaList[row][1]);
    //self.areaLabel.text = self.areaList[row][1];
    //[self hideAreaView];
}

@end
