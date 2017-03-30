//
//  ViewController+UITextFieldDelegate.m
//  2-1-19
//
//  Created by yuu ogasawara on 2017/03/30.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "ViewController.h"
#import "Const.h"

@implementation ViewController (UITextFieldDelegate)
-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSString* text = self.textField.text;
    
    UIStoryboard* showTextStoryboard = [UIStoryboard storyboardWithName:kShowTextStoryBoardFileName
                                                                 bundle:nil];
    ShowTextViewController* showVC = [showTextStoryboard instantiateInitialViewController];
    
    showVC.text = text;
    
    [self presentViewController:showVC
                       animated:YES
                     completion:nil];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.textField resignFirstResponder];
    return  YES;
}

@end
