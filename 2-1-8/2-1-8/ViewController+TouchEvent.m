//
//  ViewController+TouchEvent.m
//  2-1-8
//
//  Created by yuu ogasawara on 2017/03/22.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "ViewController.h"

const float AREA_PICKER_ACCESSORY_HEIGHT = 44;
const float AREA_PICKER_HEIGHT = 216;

@implementation ViewController (TouchEvent)

- (IBAction)labelTapped:(id)sender {
    [self showAreaView:sender];
}

- (IBAction)viewTapped:(id)sender {
    [self hideAreaView];
}

- (void)showAreaView:(id)sender
{
    //[self.view bringSubviewToFront:_overlayView]; // 最前面に移動
    self.areaView.backgroundColor = [UIColor greenColor];
    [self.view bringSubviewToFront:self.areaView]; // 最前面に移動
    //self.overlayView.frame = [[UIScreen mainScreen] bounds];
    [UIView animateWithDuration:.20 animations:^{
        self.areaView.transform = CGAffineTransformMakeTranslation(0, -(AREA_PICKER_ACCESSORY_HEIGHT + AREA_PICKER_HEIGHT));
    }];
}

@end
