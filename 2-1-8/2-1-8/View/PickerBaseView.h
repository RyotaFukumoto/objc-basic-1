//
//  PickerBaseView.h
//  2-1-8
//
//  Created by yuu ogasawara on 2017/03/24.
//  Copyright © 2017年 stv. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PickerBaseViewDelegate<NSObject>
-(void)doneButtonDidTapped:(nullable id)sender;
@end

@interface PickerBaseView : UIView
@property (nullable, weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (nullable, weak, nonatomic) IBOutlet UIButton *doneButton;
@property(nullable,nonatomic,weak) id<PickerBaseViewDelegate> delegate;
@end

