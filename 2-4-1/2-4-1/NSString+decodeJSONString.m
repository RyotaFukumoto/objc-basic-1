//
//  NSString+decodeJSONString.m
//  playAFNetworking
//
//  Created by yogasawara@stv on 2017/04/08.
//  Copyright © 2017年 smart tech ventures. All rights reserved.
//

#import "NSString+decodeJSONString.h"

@implementation NSString (decodeJSONString)
- (NSString *)decodeJSONString{
    NSString *esc1 = [self stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *esc2 = [esc1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *quoted = [[@"\"" stringByAppendingString:esc2] stringByAppendingString:@"\""];
    NSData *data = [quoted dataUsingEncoding:NSUTF8StringEncoding];
   
    NSString* unesc = [NSPropertyListSerialization propertyListWithData:data
                                                                options:NSPropertyListImmutable
                                                                 format:NULL
                                                                  error:NULL];
    
    assert([unesc isKindOfClass:[NSString class]]);
    return unesc;
}
@end
