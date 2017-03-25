//
//  TwoAnyOneManager.h
//  2-1-10
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

extern const NSString* twoAnyOne;
extern const NSString* nameKey;
extern const NSString* explanationKey;

@interface TwoAnyOneManager : NSObject
@property (nonatomic, readonly) NSArray<Member*> *members;

@end
