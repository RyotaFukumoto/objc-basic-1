//
//  DetailViewController.m
//  2-1-18
//
//  Created by yuu ogasawara on 2017/03/30.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    self.label.text = [self timeInfomationString];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 タイムゾーンなどを取得して文字列を作って返す
 @return 例：「今のタイムゾーンは日本標準時で、今日は今年の第13週で、今月の第5木曜日です。」
 */
-(NSString*)timeInfomationString{
    NSDate* nowDate = [NSDate date];
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents* dateComponents = [calender components:NSCalendarUnitWeekOfYear |
                                        NSCalendarUnitTimeZone |
                                        NSCalendarUnitWeekdayOrdinal |
                                        NSCalendarUnitWeekday
                                                   fromDate:nowDate];
    //時間帯を表す日本語の文字列を取得する
    NSTimeZone *timeZone = dateComponents.timeZone;
    NSString *timeZoneString = [timeZone localizedName:NSTimeZoneNameStyleStandard
                                                locale:[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"]];
    
    //曜日の日本語の文字列(ex:「火」「水」)を取得する
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    df.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ja"];
    NSString* weekDayStr = df.shortWeekdaySymbols[dateComponents.weekday-1];
    
    NSString* dayString = [NSString stringWithFormat:@"現在のタイムゾーン:%@\n今日は今年の第%02zd週で、今月の第%zd%@曜日です。",
                           timeZoneString,
                           dateComponents.weekOfYear,
                           dateComponents.weekdayOrdinal,
                           weekDayStr];
    return dayString;
}
@end
