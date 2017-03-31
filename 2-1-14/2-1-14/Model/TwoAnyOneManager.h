//
//  TwoAnyOneManager.h
//  2-1-14
//
//  Created by yogasawara@stv on 2017/03/25.
//  Copyright © 2017年 stv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Member.h"

typedef enum : NSInteger{
    Array = 0,
    Dictionary
}RootType;

extern NSString* const twoAnyOne;
extern NSString* const nameKey;
extern NSString* const explanationKey;

@interface TwoAnyOneManager : NSObject
@property (nonatomic, readonly) NSArray<Member*> *members;
@end
