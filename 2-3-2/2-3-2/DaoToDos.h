//
//  DaoToDos.h
//  2-3-2
//
//  Created by yuu ogasawara on 2017/04/03.
//  Copyright © 2017年 stv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
#import "ToDo.h"

@interface DaoToDos : NSObject
- (ToDo*)add:(ToDo *)todo;
@end
