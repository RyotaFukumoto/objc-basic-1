//
//  TwoAnyOneManager.m
//  2-1-14
//
//  Created by yogasawara@stv on 2017/03/25.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "TwoAnyOneManager.h"
NSString* const twoAnyOne = @"2NE1";
NSString* const nameKey = @"name";
NSString* const explanationKey = @"explanation";

@implementation TwoAnyOneManager
-(NSArray<Member*> *)members{
    //plistから取得して返す
    NSArray *array = [self objectFromPlistOf:twoAnyOne rootTypeOfPlist:Array];
    NSMutableArray<Member*> *memberArray = [NSMutableArray array];
    
    for (NSDictionary *mem in array) {
        Member *member = [[Member alloc] initWithName:mem[nameKey]
                                          explanation:mem[explanationKey]];
        [memberArray addObject:member];
    }
    
    return (NSArray *)memberArray;
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
