//
//  FavoriteProgrammingLanguage.m
//  1-1-5
//
//  Created by yuu ogasawara on 2017/03/17.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "FavoriteProgrammingLanguage.h"

@implementation FavoriteProgrammingLanguage
//MARK: デリゲートへのアクセサ
- (void)setDelegate:(id <FavoriteProgrammingLanguageDelegate>)object{
    delegate = object;
}

-(id <FavoriteProgrammingLanguageDelegate>)delegate{
    return delegate;
}

//MARK:デリゲート先への通知
-(void)joinIntern{
    //デリゲートにObjCができるようになったことを知らせる
    if ([delegate respondsToSelector:@selector(goodAtObjC)]) {
        [delegate goodAtObjC];
    }
}

@end
