//
//  ToDoDetailViewController.m
//  2-3-2
//
//  Created by yuu ogasawara on 2017/04/04.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "ToDoDetailViewController.h"
#import "DaoToDos.h"
#import "ToDo.h"

@interface ToDoDetailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *contentTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation ToDoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleTextField.delegate = self;
    self.contentTextField.delegate = self;
    
    self.datePicker.minimumDate = [NSDate date];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark button action


/**
 登録ボタンが押されたら、入力情報をDBに保存する。

 @param sender subscribeボタン
 */
- (IBAction)subscribeButtonTapped:(UIButton *)sender
{
    if ([self.titleTextField.text isEqualToString:@""]) {
        [self showAlert:NoTitle];
        return;
    }
    
    ToDo* todo = [[ToDo alloc] init];
    todo.todo_title = self.titleTextField.text;
    todo.todo_contents = self.contentTextField.text;
    todo.limit_date = self.datePicker.date;
    
    ToDo* completedTodo = [[[DaoToDos alloc] init] add:todo];
    
    if (completedTodo == nil) {
        [self showAlert:FailedToSave];
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(createdNewTask)]) {
        [self.delegate createdNewTask];
    }
}

- (IBAction)cancelButtonTapped:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

#pragma mark Alert
//アラートを出したいケースが増えたらここに追加すること
typedef NS_ENUM(NSUInteger,Error){
    NoTitle,
    FailedToSave
};

-(void)showAlert:(Error)error{
    switch (error) {
        case NoTitle:
        {
            UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Blank Title"
                                                                                     message:nil
                                                                              preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK, I'll fill in."
                                                                style:UIAlertActionStyleDefault handler:nil]];
            
            [self presentViewController:alertController
                               animated:YES
                             completion:nil];

            return;
        }
            
        case FailedToSave:{
            UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Failed to save."
                                                                                     message:nil
                                                                              preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK." style:UIAlertActionStyleDefault handler:nil]];
            
            [self presentViewController:alertController
                               animated:YES
                             completion:nil];
            
            return;
        }
            
        default:
            return;
    }
}

#pragma mark UITextFieldDelegate
//リターンキーを押したらキーボードを下げるために実装
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return  YES;
}

#pragma mark utility
+ (NSString*)className {
    return NSStringFromClass([ToDoDetailViewController class]);
}
@end
