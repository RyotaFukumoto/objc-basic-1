//
//  UserDefaultsManager.h
//  2-3-1
//
//  Created by yuu ogasawara on 2017/03/31.
//  Copyright © 2017年 stv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SaveData.h"
#import "Const.h"

@interface UserDefaultsManager : NSObject
-(SaveData*)loadData;
-(void)saveData:(SaveData*)data;
@end
