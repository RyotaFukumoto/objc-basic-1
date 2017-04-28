//
//  ControllerBase.h
//  2-6-2
//
//  Created by yuu ogasawara on 2017/04/27.
//  Copyright © 2017年 stv. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ControllerBase;
@protocol ControllerBaseDelegate <NSObject>
-(BOOL)setView:(ControllerBase*)controllerBase
           For:(NSDictionary*)query;
@end

@interface ControllerBase : NSObject

@property id<ControllerBaseDelegate> controllerBaseDelegate;

- (BOOL)action:(NSString *)action
         query:(NSDictionary *)query;
@end
