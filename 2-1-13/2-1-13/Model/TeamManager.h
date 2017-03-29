//
//  TeamManager.h
//  2-1-13
//
//  Created by yogasawara@stv on 2017/03/27.
//  Copyright © 2017年 smart tech ventures. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Team.h"

typedef enum : NSInteger{
    Array = 0,
    Dictionary
}RootType;

extern NSString* const kBLeague;
extern NSString* const tohokuKey;
extern NSString* const hokurikuKey;

@interface TeamManager : NSObject
@property (nonatomic, readonly) NSDictionary *teams;
@end
