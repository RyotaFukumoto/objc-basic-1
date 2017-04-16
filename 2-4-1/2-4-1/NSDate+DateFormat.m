//
//  NSDate+DateFormat.m
//  2-3-2
//
//  Created by yogasawara@stv on 2017/04/07.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "NSDate+DateFormat.h"

typedef NSString UTCDateString;

@implementation NSDate (DateFormat)
/**
 日時のオブジェクトからUTCでフォーマットした文字列を生成
 参考： http://qiita.com/__zck__/items/aa08e1ed8496f6da1eb9
 @return ex: "2017-04-08 13:25:03"
 
 */
-(NSString*)utcDateString{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    return [dateFormatter stringFromDate:self];
}

/**
 NSDateからシステムが使用しているタイムゾーンでフォーマットした文字列を生成
 
 @return ex) "2020-08-16"
 */
-(NSString*)systemDateString{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    return [dateFormatter stringFromDate:self];
}

/**
 UTCでフォーマットされた文字列から日時のオブジェクトを生成
 
 @param utcDateString 日時の文字列（UTCを想定）ex:"1987-07-29 11:13:00"
 @return UTCで解釈されたNSDateオブジェクト
 */
+(NSDate*)dateFrom:(UTCDateString *)utcDateString{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    return [dateFormatter dateFromString:utcDateString];
}
@end
