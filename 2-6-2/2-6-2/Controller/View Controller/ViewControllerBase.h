//
//  ViewControllerBase.h
//  2-6-2
//
//  Created by yuu ogasawara on 2017/04/27.
//  Copyright © 2017年 stv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewControllerBase : UIViewController
- (BOOL)action:(NSString *)action
         query:(NSDictionary *)query;
@end
