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
