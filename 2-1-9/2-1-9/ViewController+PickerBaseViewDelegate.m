//
//  ViewController+PickerBaseViewDelegate.m
//  2-1-9
//
//  Created by yuu ogasawara on 2017/03/23.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController (PickerBaseViewDelegate)
-(void)dateUpdated:(nonnull NSDate*)date{
    NSDateFormatter *df = [NSDateFormatter new];
    df.dateFormat = @"yyyy年MM月dd日";
    self.label.text = [df stringFromDate:date];
}

-(void)doneButtonTapped{
    [self hidePickerBaseView];
}

@end
