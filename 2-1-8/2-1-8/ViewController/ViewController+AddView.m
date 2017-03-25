//
//  ViewController+AddView.m
//  2-1-8
//
//  Created by yuu ogasawara on 2017/03/22.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController (AddView)
- (void)showPickerBaseView:(id)sender
{
    float height = self.view.bounds.size.height;
    float width = self.view.bounds.size.width;
    
    float pickerBaseViewHeight = PICKER_ACCESSORY_HEIGHT + PICKER_HEIGHT;

    self.pickerBaseView.frame = CGRectMake(0,
                                           height,
                                           width,
                                           pickerBaseViewHeight);
    
    self.pickerBaseView.pickerView.delegate = self;
    self.pickerBaseView.pickerView.dataSource = self;
    self.pickerBaseView.delegate = self;
    
    [self.view addSubview:self.pickerBaseView];

    [UIView animateWithDuration:.20
                     animations:^{
        self.pickerBaseView.transform = CGAffineTransformMakeTranslation(0, -(PICKER_ACCESSORY_HEIGHT + PICKER_HEIGHT));
    }];
}

- (void)performDoneButtonAction
{
    [self hidePickerBaseView];
}

- (void)hidePickerBaseView
{
    [UIView animateWithDuration:.20 animations:^{
        self.pickerBaseView.transform = CGAffineTransformIdentity;
    }];
}

@end
