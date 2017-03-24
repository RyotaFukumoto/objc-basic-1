//
//  ViewController+TouchEvent.m
//  2-1-8
//
//  Created by yuu ogasawara on 2017/03/22.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "ViewController.h"

const float PICKER_ACCESSORY_HEIGHT = 44;
const float PICKER_HEIGHT = 216;

@implementation ViewController (TouchEvent)

- (IBAction)labelTapped:(id)sender {
    [self showPickerBaseView:sender];
}

- (IBAction)viewTapped:(id)sender {
    [self hidePickerBaseView];
}

@end
