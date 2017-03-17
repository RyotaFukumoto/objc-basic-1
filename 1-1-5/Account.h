//
//  Account.h
//  1-1-5
//
//  Created by yuu ogasawara on 2017/03/17.
//  Copyright © 2017年 stv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FavoriteProgrammingLanguage.h"

@interface Account : NSObject{
    //【プロパティ】 氏名:文字列型 年齢:整数型 性別:文字列型 得意な言語:文字列型
    NSString *name;
    NSInteger *age;
    NSString *sex;
    NSString *favoriteLanguage;
}

-(id)initWithName:(NSString *)n
              age:(NSInteger *)a
              sex:(NSString *)s
 favoriteLanguage:(NSString *)f;

- (void)showInfo;

@end

//MARK: Adopt FavoriteProgrammingLanguageDelegate Protocol
@interface Account (FavoriteProgrammingLanguageDelegate)<FavoriteProgrammingLanguageDelegate>
-(void)goodAtObjC;
-(void)goToIntern;
@end
