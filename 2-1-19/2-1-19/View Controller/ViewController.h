//
//  ViewController.h
//  2-1-19
//
//  Created by yuu ogasawara on 2017/03/30.
//  Copyright © 2017年 stv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowTextViewController.h"
@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *textField;
@end

@interface ViewController (UITextFieldDelegate)<UITextFieldDelegate>

@end
