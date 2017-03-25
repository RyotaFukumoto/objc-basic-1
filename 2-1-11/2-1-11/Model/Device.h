//
//  Device.h
//  2-1-11
//
//  Created by yogasawara@stv on 2017/03/25.
//  Copyright © 2017年 stv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Device : NSObject
@property NSString *name;
@property NSNumber *size;
@property NSArray<NSNumber*> *capacity;
@property NSString *notices;

- (id)initWithName:(NSString *)name
              size:(NSNumber *)size
          capacity:(NSArray *)capacity
           notices:(NSString *)notices;

@end
