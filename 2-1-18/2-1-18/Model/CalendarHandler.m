//
//  CalendarHandler.m
//  2-1-18
//
//  Created by yuu ogasawara on 2017/03/31.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "CalendarHandler.h"

@implementation CalendarHandler

/**
 暦に関する情報を取得して文字列を作って返す

 @return 例：「今のタイムゾーンは日本標準時で、今日は今年の第13週で、今月の第5木曜日です。」
 */
-(NSString*)timeInfomationString
{
    NSDate* nowDate = [NSDate date];
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents* dateComponents = [calender components:NSCalendarUnitWeekOfYear |
                                        NSCalendarUnitTimeZone |
                                        NSCalendarUnitWeekdayOrdinal |
                                        NSCalendarUnitWeekday
                                                   fromDate:nowDate];
    
    //時間帯を表す日本語の文字列を取得する(ex:「日本標準時」）
    NSTimeZone *timeZone = dateComponents.timeZone;
    NSString *timeZoneJapaneseString = [timeZone localizedName:NSTimeZoneNameStyleStandard
                                                locale:[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"]];
    
    //曜日の日本語の文字列(ex:「火」「水」)を取得する
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    df.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ja"];
    NSString* weekDayJPStr = df.shortWeekdaySymbols[dateComponents.weekday-1];
    
    //ex:「現在のタイムゾーン：日本標準時
    //    今日は今年の第14週で、今月の第４木曜日です。」
    NSString* dayString = [NSString stringWithFormat:@"現在のタイムゾーン:%@\n今日は今年の第%02zd週で、今月の第%zd%@曜日です。",
                           timeZoneJapaneseString,
                           dateComponents.weekOfYear,
                           dateComponents.weekdayOrdinal,
                           weekDayJPStr];
    
    return dayString;
}
@end
