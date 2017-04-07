//
//  ToDo.h
//  2-3-2
//
//  Created by yuu ogasawara on 2017/04/03.
//  Copyright © 2017年 stv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDo : NSObject
@property (nonatomic, assign) NSInteger todoID;
@property (nonatomic,   copy) NSString* todoTitle;
@property (nonatomic,   copy) NSString* todoContents;
@property (nonatomic,   copy) NSDate*   created;
@property (nonatomic,   copy) NSDate*   modified;
@property (nonatomic,   copy) NSDate*   limitDate;
@property (nonatomic)         BOOL      deleteFlg;

@end
