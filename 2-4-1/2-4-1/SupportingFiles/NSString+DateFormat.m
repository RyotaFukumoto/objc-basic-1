//
//  NSString+DateFormat.m
//  2-4-1
//
//  Created by yogasawara@stv on 2017/04/11.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "NSString+DateFormat.h"

@implementation NSString (DateFormat)
/**
 日時のオブジェクトから日本のタイムゾーンでフォーマットした文字列を生成
 参考： http://qiita.com/__zck__/items/aa08e1ed8496f6da1eb9
 @return ex: "2017-04-08"
 
 */
+(NSString*)dateString:(NSDate*)date{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:60*60*9]];
    return [dateFormatter stringFromDate:date];
}

/**
　日本のタイムゾーンでフォーマットされた文字列から日時のオブジェクトを生成
 
 @return 日本標準時で解釈されたNSDateオブジェクト
 */
-(NSDate*)dateObject{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:60*60*9]];
    return [dateFormatter dateFromString:self];
}
@end
