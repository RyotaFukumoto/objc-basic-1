//
//  DeviceManager.m
//  2-1-11
//
//  Created by yogasawara@stv on 2017/03/25.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "DeviceManager.h"
const NSString* device = @"Devices";
const NSString* nameKey = @"name";
const NSString* sizeKey = @"size";
const NSString* capacityKey = @"capacity";
const NSString* noticesKey = @"notices";

@implementation DeviceManager
-(NSArray *)devices{
    //plistから取得して返す
    NSArray *rootArray = [self objectFromPlistOf:device rootTypeOfPlist:Array];
    NSMutableArray *appleDevicesArray = [NSMutableArray array];
    
    for (NSArray *dArray in rootArray) {
        //dArrayはiPhoneとiPadそれぞれあり、deviceArrayに移し替える
        NSMutableArray<Device*> *deviceArray = [NSMutableArray array];
        //deviceDictionaryは、個々のデバイスの情報を格納している。
        //Deviceクラスに移し替えてdeviceArrayに入れる
        for (NSDictionary *deviceDictionary in dArray) {
            Device *device = [[Device alloc] initWithName:deviceDictionary[nameKey]
                                                     size:deviceDictionary[sizeKey]
                                                 capacity:deviceDictionary[capacityKey] notices:deviceDictionary[noticesKey]];
            
            [deviceArray addObject:device];
        }
        [appleDevicesArray addObject:deviceArray];
    }
    
    return (NSArray *)appleDevicesArray;
}

/**
 plistからオブジェクトを取得する
 
 @param fileName plistの名前
 @param type plistのrootの型。
 @return plistから取得したオブジェクト。
 */
- (id)objectFromPlistOf:(NSString *)fileName
        rootTypeOfPlist:(RootType)type
{
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:fileName ofType:@"plist"];
    
    switch (type) {
        case Array:
            return [NSArray arrayWithContentsOfFile:path];
            break;
            
        case Dictionary:
            return [NSDictionary dictionaryWithContentsOfFile:path];
            break;
    }
}
@end
