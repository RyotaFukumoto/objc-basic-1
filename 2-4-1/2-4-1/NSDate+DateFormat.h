//
//  NSDate+DateFormat.h
//  2-3-2
//
//  Created by yogasawara@stv on 2017/04/07.
//  Copyright © 2017年 stv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (DateFormat)
-(NSString*)utcDateString;
-(NSString*)systemDateString;
+(NSDate*)dateFrom:(NSString *)utcDateString;
@end
