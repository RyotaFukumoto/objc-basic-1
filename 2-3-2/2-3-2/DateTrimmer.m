//
//  DateTrimmer.m
//  2-3-2
//
//  Created by yuu ogasawara on 2017/04/04.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "DateTrimmer.h"

@implementation DateTrimmer


/**
 日時のオブジェクトからUTCでフォーマットした文字列を生成
 参考： http://qiita.com/__zck__/items/aa08e1ed8496f6da1eb9
 @param date ロケールを問わない日時
 @return UTCでフォーマットした日時の文字列
 ex: 2017-04-08 13:25:03
 */
+(NSString*)utcDateString:(NSDate*)date{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    return [dateFormatter stringFromDate:date];
}

/**
 UTCでフォーマットされた文字列から日時のオブジェクトを生成

 @param utcDateString 日時の文字列（UTCを想定）
 @return UTCで解釈された日時
 */
+(NSDate*)dateFrom:(NSString *)utcDateString{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    return [dateFormatter dateFromString:utcDateString];
}
@end
