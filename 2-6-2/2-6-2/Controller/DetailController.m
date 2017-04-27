//
//  DetailController.m
//  2-6-2
//
//  Created by yuu ogasawara on 2017/04/27.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "DetailController.h"

@implementation DetailController
- (BOOL)showAction:(NSDictionary *)query
{
    if (query[@"title"] && query[@"key"]) {
        //[self configureView:query];
        //TODO: ViewControllerにDetailViewControllerを表示するように実装
        return YES;
    }
    
    return NO;
}

@end
