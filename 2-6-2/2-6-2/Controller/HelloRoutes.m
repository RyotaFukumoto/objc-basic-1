//
//  HelloRoutes.m
//  2-6-2
//
//  Created by yuu ogasawara on 2017/04/28.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "HelloRoutes.h"
#import "NSString+dictionaryFromQueryString.h"
#import "ViewController.h"

@implementation HelloRoutes

-(BOOL)openURL:(NSURL *)url{
    NSDictionary *query = [[url query] dictionaryFromQueryString];
    ViewController* viewController = (ViewController*)[self getTopMostViewController];
    
    [viewController show:query];
    
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
