//
//  Member.m
//  2-1-10
//
//  Created by yogasawara@stv on 2017/03/25.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "Member.h"

@implementation Member
-(id)initWithName:(NSString *)name
      explanation:(NSString *)explanation{
    self->_name = name;
    self->_explanation = explanation;
    return self;
}
@end
