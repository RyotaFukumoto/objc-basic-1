//
//  UserDefaultsManager.m
//  2-3-1
//
//  Created by yuu ogasawara on 2017/03/31.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "UserDefaultsManager.h"

@implementation UserDefaultsManager
-(void)saveData:(SaveData *)data{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    [ud setInteger:data.integer forKey:intKey];
    [ud setDouble:data.doubleNumber forKey:doubleKey];
    [ud setObject:data.string forKey:stringKey];
    
    [ud synchronize];

}


-(SaveData *)loadData{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    SaveData *data = [SaveData alloc];
    data.integer = [ud integerForKey:intKey];
    data.doubleNumber = [ud doubleForKey:doubleKey];
    data.string = [ud stringForKey:stringKey];
    
    return data;
}

@end
