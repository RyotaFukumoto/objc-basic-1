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

@interface ViewController : UIViewController
@property(nullable, nonatomic, strong) IBOutlet PickerBaseView *pickerBaseView;
@property(nullable, nonatomic, strong) NSArray<NSString*> *roomList;
@property (nullable, weak, nonatomic) IBOutlet UILabel *label;

@end

@interface ViewController (TouchEvent)<PickerBaseViewDelegate>
-(void)doneButtonDidTapped:(nonnull id)sender;
@end

@interface ViewController (AddView)
- (void)showPickerBaseView:(nullable id)sender;
- (void)hidePickerBaseView;
@end

@interface ViewController (PickerView)<UIPickerViewDelegate,UIPickerViewDelegate>
@end
