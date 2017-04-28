//
//  BiographyController.m
//  2-6-2
//
//  Created by yuu ogasawara on 2017/04/28.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "BiographyController.h"

@implementation BiographyController
- (BOOL)showAction:(NSDictionary *)query{
    if ([self.controllerBaseDelegate respondsToSelector:@selector(setView:For:)])
    {
        return [self.controllerBaseDelegate setView:self
                                                For:query];
    }
    return NO;
}

@end
