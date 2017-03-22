//
//  ViewController.h
//  2-1-8
//
//  Created by yuu ogasawara on 2017/03/22.
//  Copyright © 2017年 stv. All rights reserved.
//

#import <UIKit/UIKit.h>

extern const float AREA_PICKER_ACCESSORY_HEIGHT;
extern const float AREA_PICKER_HEIGHT;

@interface ViewController : UIViewController{
    
}
@property(nonatomic, strong) UIView *areaView;
@property(nonatomic, strong) UIPickerView *areaPickerView;
@property(nonatomic, strong) NSArray<NSString*> *roomList;
@property (weak, nonatomic) IBOutlet UILabel *label;


@end

@interface ViewController (TouchEvent)

@end

@interface ViewController (AddView)
- (void)buildAreaPickerView;
- (void)hideAreaView;
@end

@interface ViewController (PickerView)<UIPickerViewDelegate,UIPickerViewDataSource>
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
@end
