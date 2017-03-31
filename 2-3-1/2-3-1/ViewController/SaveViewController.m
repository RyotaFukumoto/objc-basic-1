//
//  SaveViewController.m
//  2-3-1
//
//  Created by yuu ogasawara on 2017/03/31.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "SaveViewController.h"
#import "Const.h"
#import "UserDefaultsManager.h"

@interface SaveViewController ()
@property (weak, nonatomic) IBOutlet UITextField *intTextField;
@property (weak, nonatomic) IBOutlet UITextField *doubleTextField;
@property (weak, nonatomic) IBOutlet UITextField *stringTextField;
@end

@implementation SaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self saveTextFieldData];
}

@end

@implementation SaveViewController (UserDefaults)
///テキストフィールドの入力値を保存する
-(void)saveTextFieldData{
    NSInteger integer = [self.intTextField.text intValue];
    double d = [self.doubleTextField.text doubleValue];
    NSString *string = self.stringTextField.text;
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    [ud setInteger:integer forKey:intKey];
    [ud setDouble:d forKey:doubleKey];
    [ud setObject:string forKey:stringKey];
    
    [ud synchronize];
}

///テキストフィールドに保存していた値を表示する
-(void)displayDataToTextFields{
    UserDefaultsManager* udm = [[UserDefaultsManager alloc] init];
    SaveData* data = [udm loadData];

    if (data == nil) {
        data.integer = 365;
        data.doubleNumber = 42.195;
        data.string = @"input here.";
    }
    
    self.intTextField.text = [NSString stringWithFormat:@"%zd",data.integer];
    self.doubleTextField.text = [NSString stringWithFormat:@"%f",data.doubleNumber];
    self.stringTextField.text = data.string;
}

@end


@implementation SaveViewController (UITextFieldDelegate)
///リターンキーを押したらキーボードを下げるために実装
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [self saveTextFieldData];
    return  YES;
}

@end
