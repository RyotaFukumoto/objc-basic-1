//
//  pickerBaseView.m
//  2-1-9
//
//  Created by yuu ogasawara on 2017/03/22.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "pickerBaseView.h"


const float PICKER_ACCESSORY_HEIGHT = 44;
const float PICKER_HEIGHT = 216;
const float DONE_BUTTON_WEDTH = 80;

@implementation PickerBaseView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];

    // 2-1. アクセサリビュー作成
    UIView *pickerAccessoryView =
    [[UIView alloc] initWithFrame:CGRectMake(0,
                                             0,
                                             frame.size.width,
                                             PICKER_ACCESSORY_HEIGHT)];
    
    pickerAccessoryView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    // 2-2. 決定ボタン作成
    UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    doneBtn.frame = CGRectMake(frame.size.width - DONE_BUTTON_WEDTH,
                               4,
                               DONE_BUTTON_WEDTH,
                               36);
    doneBtn.backgroundColor = [UIColor whiteColor];
    doneBtn.tintColor = [UIColor blueColor];
    [doneBtn setTitle:@"Done" forState:UIControlStateNormal];
    [doneBtn addTarget:self
                action:@selector(performDoneButtonAction)
      forControlEvents:UIControlEventTouchUpInside];
    
    //2-3. 決定ボタンをアクセサリービューに乗せて、pickerBaseViewに加える
    [pickerAccessoryView addSubview:doneBtn];
    [self addSubview:pickerAccessoryView];
    
    return self;
}

-(void)performDoneButtonAction{
    //ボタンが押された時の挙動
}

@end
