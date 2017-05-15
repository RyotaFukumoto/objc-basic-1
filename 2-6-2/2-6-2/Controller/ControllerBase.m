//
//  ControllerBase.m
//  2-6-2
//
//  Created by yuu ogasawara on 2017/04/27.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "ControllerBase.h"

@implementation ControllerBase
- (BOOL)action:(NSString *)action
         query:(NSDictionary *)query{
    
    SEL sel = NSSelectorFromString([NSString stringWithFormat:@"%@Action:", action]);
    
    if ([self respondsToSelector:sel]) {
        BOOL (*actionImp)(id, SEL, NSDictionary *);
        actionImp = (BOOL (*)(id, SEL, NSDictionary *))[self methodForSelector:sel];
        return actionImp(self, sel, query);
    }
    return NO;
}
@end
