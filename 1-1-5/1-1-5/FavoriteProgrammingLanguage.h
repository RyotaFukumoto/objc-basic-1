//
//  FavoriteProgrammingLanguage.h
//  1-1-5
//
//  Created by yuu ogasawara on 2017/03/17.
//  Copyright © 2017年 stv. All rights reserved.
//

#import <Foundation/Foundation.h>

//MARK: FavoriteProgrammingLanguageDelegate Protocol
@protocol FavoriteProgrammingLanguageDelegate <NSObject>
@optional
-(void)goodAtObjC;
@end

//MARK: FavoriteProgrammingLanguage Protocol
@interface FavoriteProgrammingLanguage : NSObject{
    id <FavoriteProgrammingLanguageDelegate> delegate;
}
//デリゲートへのアクセサ
- (void)setDelegate:(id <FavoriteProgrammingLanguageDelegate>)Object;
-(id <FavoriteProgrammingLanguageDelegate>)delegate;

//インターンに参加することを知らせるメソッド
-(void)joinIntern;
@end

