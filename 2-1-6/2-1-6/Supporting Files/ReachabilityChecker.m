//
//  ReachabilityChecker.m
//  2-1-6
//
//  Created by yuu ogasawara on 2017/03/21.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "ReachabilityChecker.h"

@implementation ReachabilityChecker
+(BOOL)checkReachability{
    Reachability *currentReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus netStatus = [currentReachability currentReachabilityStatus];
    
    switch (netStatus)
    {
        case NotReachable:        {
            // 圏外の場合の処理
            return NO;
            break;
        }
            
        case ReachableViaWWAN:        {
            // 携帯回線に接続可能な場合の処理
            return YES;
            break;
        }
            
        case ReachableViaWiFi:        {
            // wifiに接続可能な場合の処理
            return YES;
            break;
        }
    }
}

@end
