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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark button action
- (IBAction)subscribeButtonTapped:(UIButton *)sender
{
    if ([self.titleTextField.text isEqualToString:@""]) {
        [self showAlert];
        return;
    }
    
    ToDo* todo = [[ToDo alloc] init];
    todo.todo_title = self.titleTextField.text;
    todo.todo_contents = self.contentTextField.text;
    todo.limit_date = self.datePicker.date;
    
    [[[DaoToDos alloc] init] add:todo];
    
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

- (IBAction)cancelButtonTapped:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

-(void)showAlert{
    //タイトルを埋めるようにメッセージ
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Fill in title field."
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK, tell title" style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alertController
                       animated:YES
                     completion:nil];
}

#pragma mark UITextFieldDelegate
//リターンキーを押したらキーボードを下げるために実装
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return  YES;
}

@end
