//
//  ViewController.h
//  2-1-8
//
//  Created by yuu ogasawara on 2017/03/22.
//  Copyright © 2017年 stv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickerBaseView.h"

extern const float PICKER_ACCESSORY_HEIGHT;
extern const float PICKER_HEIGHT;

@interface ViewController : UIViewController{
    
}

@property(nullable, nonatomic, strong) IBOutlet PickerBaseView *pickerBaseView;
@property(nullable, nonatomic, strong) NSArray<NSString*> *roomList;
@property (nullable, weak, nonatomic) IBOutlet UILabel *label;


@end

@interface ViewController (TouchEvent)

@end

@interface ViewController (AddView)
- (void)buildPickerView;
- (void)showPickerBaseView:(nullable id)sender;
- (void)hidePickerBaseView;
@end

@interface ViewController (PickerView)<UIPickerViewDelegate,UIPickerViewDataSource>
- (NSInteger)numberOfComponentsInPickerView:(nullable UIPickerView *)pickerView;
- (NSInteger)pickerView:(nullable UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
- (nullable NSString *)pickerView:(nullable UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
- (void)pickerView:(nullable UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
@end
