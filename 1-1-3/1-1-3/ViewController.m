//
//  ViewController.m
//  1-1-3
//
//  Created by yuu ogasawara on 2017/03/17.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "ViewController.h"

//公開する必要の無いインスタンス変数は、mファイル側に書く
//これでインスタンス変数を隠蔽できる
//http://qiita.com/takabosoft/items/50886fc211a4033856d2
//https://developer.apple.com/jp/documentation/CodingGuidelines.pdf
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDate *date = [NSDate date];
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *dateDetail = [calender components:NSCalendarUnitMonth | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:date];
    
    //if文
    NSLog(@"--------if文--------");
    if (dateDetail.month == 1) {
        NSLog(@"明けましておめでとうございます");
    }
    
    //if else文
    NSLog(@"--------if else文--------");
    if (dateDetail.weekday == 1 || dateDetail.weekday == 7){
        NSLog(@"週末ですね。ゆっくりしましょう。");
    }else{
        NSLog(@"平日ですね。夕飯はどうしますか？");
    }

    //if else if文
    NSLog(@"--------if else if文--------");
    if (dateDetail.hour < 12) {
        NSLog(@"お早うございます");
    } else if (dateDetail.hour < 17){
        NSLog(@"こんにちは");
    }else {
        NSLog(@"こんばんは");
    }

    //三項演算子
    NSLog(@"--------三項演算子--------");
    (dateDetail.month == 0) ? NSLog(@"今年はまだ前半ですね") :NSLog(@"今年ももう半分以上終わってしまいました");

    //for文
    NSLog(@"--------for文--------");
    for (int i = 1; i <= 10; i++){
        if (i % 3 == 0){
            NSLog(@"%dっ", i);
        }else if (i % 5 == 0){
            NSLog(@"%d🐶",i);
        }else{
            NSLog(@"%d", i);
        }
    }

    //高速列挙構文
    NSLog(@"--------高速列挙構文--------");
    NSArray *mangArray = @[@"肉まん",@"あんまん",@"カレーまん",@"ピザまん"];
    for (NSString *mang in mangArray) {
        NSLog(@"%@", mang);
    }

    //switch文
    NSLog(@"--------switch文--------");
    int value = arc4random_uniform(6);
    switch (value % 2) {
        case 0:
            NSLog(@"出た目は偶数です");
            break;
        default:
            NSLog(@"出た目は奇数です");
            break;
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
