//
//  TeamManager.m
//  2-1-13
//
//  Created by yogasawara@stv on 2017/03/27.
//  Copyright © 2017年 smart tech ventures. All rights reserved.
//

#import "TeamManager.h"

NSString* const kBLeague = @"BLeague";
NSString* const nameKey = @"name";
NSString* const imageKey = @"image";
NSString* const tohokuKey = @"東北";
NSString* const hokurikuKey = @"北陸";


@implementation TeamManager

/**
 plistから取得したチームの辞書を返す。
 @return plistから取得したチームの辞書。地域名がキーで、値は地域毎のチーム（Team型）が入った配列。
 */
-(NSDictionary *)teams{
    //plistから取得して返す
    NSDictionary<NSString*, NSArray*> *plistDictionary = [self objectFromPlistOf:kBLeague
                                           rootTypeOfPlist:Dictionary];
    NSMutableDictionary<NSString*,NSMutableArray*> *teamDictionary = [NSMutableDictionary dictionary];
    
    for (NSString* key in [plistDictionary keyEnumerator]) {
        NSArray<NSString*> *regionPlistArray = plistDictionary[key];
        NSMutableArray<Team*> *regionTeamArray = [NSMutableArray array];
        
        for (NSString* teamName in regionPlistArray) {
            Team *team = [[Team alloc] initWithName:teamName
                                              image:[UIImage imageNamed:teamName]];
            [regionTeamArray addObject:team];
        }
        [teamDictionary setValue:regionTeamArray forKey:key];
    }
    
    return teamDictionary;
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
