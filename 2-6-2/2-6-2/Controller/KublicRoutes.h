//
//  Routes.h
//  2-6-2
//
//  Created by yuu ogasawara on 2017/04/27.
//  Copyright © 2017年 stv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ControllerBase.h"

@interface KublicRoutes : NSObject

@property ControllerBase* controllerBase;
- (BOOL)openURL:(NSURL *)url;

@end
