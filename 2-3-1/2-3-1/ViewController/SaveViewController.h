//
//  SaveViewController.h
//  2-3-1
//
//  Created by yuu ogasawara on 2017/03/31.
//  Copyright © 2017年 stv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SaveViewController : UIViewController

@end

@interface SaveViewController (UserDefaults)
-(void)saveTextFieldData;
-(void)displayDataToTextFields;
@end

@interface SaveViewController (UITextFieldDelegate)<UITextFieldDelegate>
@end
