//
//  Team.h
//  2-1-13
//
//  Created by yogasawara@stv on 2017/03/27.
//  Copyright © 2017年 smart tech ventures. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Team : NSObject
@property NSString *name;
@property UIImage *image;
-(id)initWithName:(NSString *)name
            image:(UIImage *)image;

@end
