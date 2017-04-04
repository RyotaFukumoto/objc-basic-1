//
//  ToDo.h
//  2-3-2
//
//  Created by yuu ogasawara on 2017/04/03.
//  Copyright © 2017年 stv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDo : NSObject
@property (nonatomic, assign) NSInteger todo_id;
@property (nonatomic,   copy) NSString* todo_title;
@property (nonatomic,   copy) NSString* todo_contents;
@property (nonatomic,   copy) NSDate*   created;
@property (nonatomic,   copy) NSDate*   modified;
@property (nonatomic,   copy) NSDate*   limit_date;
@property (nonatomic)         BOOL      delete_flg;

@end
