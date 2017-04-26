//
//  AppDelegate.m
//  2-5-9
//
//  Created by yogasawara@stv on 2017/04/24.
//  Copyright © 2017年 smart tech ventures. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
@import AudioToolbox;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //通知の設定・許可を求める処理
    UNAuthorizationOptions authOptions = UNAuthorizationOptionAlert | UNAuthorizationOptionSound |UNAuthorizationOptionBadge;
    
    [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:authOptions
                                                                        completionHandler:^(BOOL granted, NSError * _Nullable error) {
                                                                            NSLog(@"authorization %@", granted ? @"granted." : @"denied.");
                                                                            
                                                                            if (granted) {
                                                                                [[UIApplication sharedApplication] registerForRemoteNotifications];
                                                                            }
                                                                            if (error) {
                                                                                NSLog(@"error : %@",error.localizedDescription);
                                                                            }}];
    
    // For iOS 10 display notification (sent via APNS)
    [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    //バッジを消す
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark Push Notification
-(void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"didFailToRegisterForRemoteNotificationsWithError: %@",error.localizedDescription);
}

/**
 リモート通知登録成功時に呼ばれる。
 @discussion  [[UIApplication sharedApplication] registerForRemoteNotifications];で、登録が成功すると呼ばれる。
 また、デバイストークンが渡されるので、サーバーに渡すとこのデバイスにリモート通知できるようになる。
 deviceTokenをNSStringに変換するやり方についてはhttp://stackoverflow.com/questions/9372815/how-can-i-convert-my-device-token-nsdata-into-an-nsstringを参照のこと。
 
 @param application _
 @param deviceToken Firebaseのインスタンスに渡す
 */
-(void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
    NSString *deviceTokenString = [self stringWithDeviceToken:deviceToken];
    NSLog(@"deviceTokenString:%@",deviceTokenString);
}

/**
 http://stackoverflow.com/questions/9372815/how-can-i-convert-my-device-token-nsdata-into-an-nsstringを参照のこと。
 
 @param deviceToken リモート通知登録成功時に、デバイスに対して発行されるAPNs用のID
 @return デバイストークンをNSStringに変換したもの
 */
- (NSString *)stringWithDeviceToken:(NSData *)deviceToken {
    const char *data = [deviceToken bytes];
    NSMutableString *token = [NSMutableString string];
    
    for (NSUInteger i = 0; i < [deviceToken length]; i++) {
        [token appendFormat:@"%02.2hhX", data[i]];
    }
    
    return [token copy];
}

/**
 リモート通知をフォアグラウンドで受け取った場合、ログとヴァイブレーションで知らせる.画面にアラートを出す。
 https://i-app-tec.com/ios/apns-test.html
 
 @param center <#center description#>
 @param notification <#notification description#>
 @param completionHandler <#completionHandler description#>
 */
-(void)userNotificationCenter:(UNUserNotificationCenter *)center
      willPresentNotification:(UNNotification *)notification
        withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    
    NSString* messageBody = notification.request.content.body;
    NSLog(@"Push notification body:%@",messageBody);
    
    AudioServicesPlayAlertSoundWithCompletion(kSystemSoundID_Vibrate, nil);
    
    ViewController* vc = (ViewController*)self.window.rootViewController;
    if (vc) {
        [vc alertPushNotifications:messageBody];
    }
    
    //バッジを消す
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}
@end
