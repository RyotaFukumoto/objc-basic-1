//
//  ViewController.h
//  2-1-7
//
//  Created by yuu ogasawara on 2017/03/22.
//  Copyright © 2017年 stv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *textField;
@end

@interface ViewController (UITextFieldDelegate)<UITextFieldDelegate>
//UITextFieldで入力文字数を制限するために実装
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
@end
