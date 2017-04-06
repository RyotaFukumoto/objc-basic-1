//
//  DateTrimmer.h
//  2-3-2
//
//  Created by yuu ogasawara on 2017/04/04.
//  Copyright © 2017年 stv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateTrimmer : NSObject
+(NSString*)utcDateString:(NSDate*)date;
+(NSString*)systemDateString:(NSDate*)date;
+(NSDate*)dateFrom:(NSString*)utcDateString;
@end
