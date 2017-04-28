//
//  Routes.m
//  2-6-2
//
//  Created by yuu ogasawara on 2017/04/27.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "KublicRoutes.h"
#import "NSString+dictionaryFromQueryString.h"
#import "ViewController.h"
#import "DetailController.h"
#import "BiographyController.h"

@implementation KublicRoutes

/**
 urlスキームのスキームがKublicだった場合に呼ばれる。クエリのホスト名を元に、各コントローラにクエリ（の処理）を振り分ける

 @param url 例：kubrick://detail/show?title=Paths_Of_Glory&key=year
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
        self.controllerBase = [[controllerClass alloc] init];
        
        //controllerが直接VCに処理を委譲するものだった場合、個別にDelegateを(VCに)設定する
        if ([controllerClass isSubclassOfClass:[DetailController class]] || [controllerClass isSubclassOfClass:[BiographyController class]]) {
            ViewController* vc = (ViewController*)[self getTopMostViewController];
            self.controllerBase.controllerBaseDelegate = vc;
        }
        
        return [self.controllerBase action:[url lastPathComponent]
                            query:[[url query] dictionaryFromQueryString]];
    }
    
    return NO;
}


/**

 @return 最前面のView Controller
 */
-(UIViewController*)getTopMostViewController{
    UIViewController* tc = [UIApplication sharedApplication].keyWindow.rootViewController;
    //tcとしてUINavigation Contollerが取れると、presentedVCではうまくいかないので、別に処理する
    if ([tc isKindOfClass:[UINavigationController class]]){
        tc = tc.childViewControllers[0];
    }
    while (tc.presentedViewController != nil){
        tc = tc.presentedViewController;
    }
    return tc;
}
@end
