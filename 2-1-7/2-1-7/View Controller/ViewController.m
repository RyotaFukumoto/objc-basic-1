//
//  ViewController.m
//  2-1-7
//
//  Created by yuu ogasawara on 2017/03/22.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@end

@implementation ViewController
#pragma mark Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.textField.delegate = self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Touch Event
//キーボード以外をタッチした場合、キーボードを下げる
-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    if ([self.textField isFirstResponder]) {
        //キーボードが表示されているので、消す
        [self.textField resignFirstResponder];
    }else{
        //キーボードが非表示なので、表示する
        //[self.textField becomeFirstResponder];
    }
}
@end
