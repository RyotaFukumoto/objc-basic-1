//
//  pickerBaseView.h
//  2-1-9
//
//  Created by yuu ogasawara on 2017/03/22.
//  Copyright © 2017年 stv. All rights reserved.
//


#import <UIKit/UIKit.h>

@protocol PickerBaseViewDelegate <NSObject>
-(void)dateUpdated:(nonnull NSDate*)date;
-(void)doneButtonTapped;
@end

@interface PickerBaseView : UIView
@property(nullable, nonatomic, strong) UIDatePicker *datePicker;
@property(nullable, weak) id <PickerBaseViewDelegate> delegate;

extern const float PICKER_ACCESSORY_HEIGHT;
extern const float PICKER_HEIGHT;

-(nonnull id)initWithFrame:(CGRect)frame;

@end
