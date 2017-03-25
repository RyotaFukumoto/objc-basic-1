//
//  ViewController+UITextFieldDelegate.m
//  2-1-7
//
//  Created by yuu ogasawara on 2017/03/22.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController (UITextFieldDelegate)

//最大入力文字数の制限
- (BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string
{//https://www.tamurasouko.com/?p=940
    // 最大入力文字数
    int maxInputLength = 30;
    
    // 入力済みのテキストを取得
    NSMutableString *str = [textField.text mutableCopy];
    
    // 入力済みのテキストと入力が行われたテキストを結合
    [str replaceCharactersInRange:range withString:string];
    
    if ([str length] > maxInputLength) {
        // ※ここに文字数制限を超えたことを通知する処理を追加
        
        return NO;
    }
    
    return YES;
}


@end
