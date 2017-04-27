//
//  Routes.m
//  2-6-2
//
//  Created by yuu ogasawara on 2017/04/27.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "KublicRoutes.h"
#import "ViewControllerProtocol.h"
#import "ViewControllerBase.h"
#import "NSString+dictionaryFromQueryString.h"
#import "ControllerBase.h"

@implementation KublicRoutes

/**
 urlスキームのスキームがKublicだった場合に呼ばれる。クエリのホスト名を元に、各コントローラにクエリ（の処理）を振り分ける

 @param url 例：(kublic://)detail/show?title=paths_of_glory&key=year
 @return 渡したクエリの処理が成功したらYES
 */
- (BOOL)openURL:(NSURL *)url
{
    NSString *controllerName = [url host];
    
    // 先頭の一文字を大文字にする
    controllerName = [controllerName stringByReplacingCharactersInRange:NSMakeRange(0,1)
                                                             withString:[[controllerName substringToIndex:1] capitalizedString]];
    
    // Classを文字列から取得
    Class controllerClass = NSClassFromString([NSString stringWithFormat:@"%@Controller",controllerName]);
    
    if ([controllerClass isSubclassOfClass:[ControllerBase class]]) {
        ControllerBase* controller = [[controllerClass alloc] init];
        
        return [controller action:[url lastPathComponent]
                            query:[[url query] dictionaryFromQueryString]];
    }
    return NO;
}
@end
