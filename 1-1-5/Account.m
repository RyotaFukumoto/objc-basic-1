//
//  Account.m
//  1-1-5
//
//  Created by yuu ogasawara on 2017/03/17.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "Account.h"

@implementation Account{
    
}

-(id)initWithName:(NSString *)n
              age:(NSInteger *)a
              sex:(NSString *)s
 favoriteLanguage:(NSString *)f
{
    self = [super init];
    if (self != nil){
        self->name = n;
        age = a;
        sex = s;
        favoriteLanguage = f;
    }
    return self;
}

//【メソッド】 男性の場合、「○○君は、○○が得意な○○歳です。」と表示する
//女性の場合、「○○さんは、○○が得意な○○歳です。」と表 示する。
- (void)showInfo{
    if ([sex  isEqual: @"男性"]) {
        NSLog(@"%@君は、%@が得意な%zd歳です。",name,favoriteLanguage,age);
    }else{
        NSLog(@"%@さんは、%@が得意な%zd歳です。",name,favoriteLanguage,age);
    }
}

@end

