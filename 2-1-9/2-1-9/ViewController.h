//
//  ViewController.h
//  2-1-9
//
//  Created by yuu ogasawara on 2017/03/22.
//  Copyright © 2017年 stv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickerBaseView.h"

@interface ViewController : UIViewController
@property (nullable, weak, nonatomic)  IBOutlet UILabel *label;
@property (nonnull) PickerBaseView *pickerBaseView;

- (IBAction)labelTapped:(nonnull id)sender;
-(void)datePickerUpdated:(nonnull id)sender;

@end

@interface ViewController (DatePickerDelegate)<PickerBaseViewDelegate>
-(void)dateUpdated:(nonnull NSDate*)date;

@end
