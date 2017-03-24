//
//  ViewController.h
//  2-1-10
//
//  Created by yuu ogasawara on 2017/03/23.
//  Copyright © 2017年 stv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property NSArray<NSString *> *members;
@property NSArray<NSString *> *descriptions;
@end

@interface ViewController (UITableViewDataSource)<UITableViewDataSource>

@end
