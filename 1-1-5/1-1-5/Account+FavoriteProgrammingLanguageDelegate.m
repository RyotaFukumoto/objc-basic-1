//
//  Account+FavoriteProgrammingLanguageDelegate.m
//  1-1-5
//
//  Created by yuu ogasawara on 2017/03/17.
//  Copyright © 2017年 stv. All rights reserved.
//
#import "Account.h"

@implementation Account (FavoriteProgrammingLanguageDelegate)
-(void)goodAtObjC{
    NSLog(@"%@はObjective Cができるようになった！🎉",name);
}
-(void)goToIntern{
    FavoriteProgrammingLanguage *intern = [[FavoriteProgrammingLanguage alloc] init];
    [intern setDelegate:self];
    [intern joinIntern];
}
@end
