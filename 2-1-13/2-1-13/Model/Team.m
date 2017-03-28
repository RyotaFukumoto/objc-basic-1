//
//  Team.m
//  2-1-13
//
//  Created by yogasawara@stv on 2017/03/27.
//  Copyright © 2017年 smart tech ventures. All rights reserved.
//

#import "Team.h"

@implementation Team
-(id)initWithName:(NSString *)name
             image:(UIImage *)image
{
    self->_name = name;
    self->_image = image;
    return  self;
}
@end
