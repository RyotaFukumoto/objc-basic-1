//
//  AppDelegate.h
//  2-5-8
//
//  Created by yuu ogasawara on 2017/04/21.
//  Copyright © 2017年 stv. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;
@import UserNotifications;

@interface AppDelegate : UIResponder <UIApplicationDelegate,UNUserNotificationCenterDelegate,FIRMessagingDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

