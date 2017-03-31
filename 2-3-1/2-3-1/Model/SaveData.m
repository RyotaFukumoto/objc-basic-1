//
//  SaveData.m
//  2-3-1
//
//  Created by yuu ogasawara on 2017/03/31.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "SaveData.h"

@implementation SaveData
-(SaveData*)initWithInt:(NSInteger)integer
                 double:(double)doubleNumer
                 string:(NSString *)string{
    self = [super init];
    if (self != nil) {
        self.integer = integer;
        self.doubleNumber = doubleNumer;
        self.string = string;
    }
    
    return self;
}
@end
