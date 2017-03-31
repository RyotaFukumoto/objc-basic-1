//
//  SaveData.h
//  2-3-1
//
//  Created by yuu ogasawara on 2017/03/31.
//  Copyright © 2017年 stv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SaveData : NSObject
@property NSInteger integer;
@property double doubleNumber;
@property NSString *string;

-(SaveData*)initWithInt:(NSInteger)integer
                 double:(double)doubleNumer
                 string:(NSString*)string;
@end
