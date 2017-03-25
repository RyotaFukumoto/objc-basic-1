//
//  DeviceManager.h
//  2-1-11
//
//  Created by yogasawara@stv on 2017/03/25.
//  Copyright © 2017年 stv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Device.h"

typedef enum : NSInteger{
    Array = 0,
    Dictionary
}RootType;

extern const NSString* device;
extern const NSString* nameKey;
extern const NSString* capacityKey;
extern const NSString* noticesKey;

@interface DeviceManager : NSObject
@property (nonatomic, readonly) NSArray *devices;
@end
