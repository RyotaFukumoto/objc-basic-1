//
//  NSString+DateFormat.h
//  2-4-1
//
//  Created by yogasawara@stv on 2017/04/11.
//  Copyright © 2017年 stv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DateFormat)
+(NSString*)dateString:(NSDate*)date;
-(NSDate*)dateObject;
@end
