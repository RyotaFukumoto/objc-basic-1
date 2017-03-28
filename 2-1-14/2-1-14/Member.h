//
//  Member.h
//  2-1-10
//
//  Created by yogasawara@stv on 2017/03/25.
//  Copyright © 2017年 stv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Member : NSObject
@property NSString *name;
@property NSString *explanation;
- (id)initWithName:(NSString *)name explanation:(NSString *)explanation;
@end
