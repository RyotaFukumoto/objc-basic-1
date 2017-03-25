//
//  Device.m
//  2-1-11
//
//  Created by yogasawara@stv on 2017/03/25.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "Device.h"

@implementation Device
-(id)initWithName:(NSString *)name
             size:(NSNumber *)size
         capacity:(NSArray *)capacity
          notices:(NSString *)notices
{
    self->_name = name;
    self->_size = size;
    self->_capacity = capacity;
    self->_notices = notices;
    return  self;
}
@end
