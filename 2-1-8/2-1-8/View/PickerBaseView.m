//
//  PickerBaseView.m
//  2-1-8
//
//  Created by yuu ogasawara on 2017/03/24.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "PickerBaseView.h"

@implementation PickerBaseView
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    [self.pickerView selectRow:0 inComponent:0 animated:NO];
    
    return self;
}

- (IBAction)doneButtonTapped:(id)sender {
    NSLog(@"doneButtonTapped");
}

@end
