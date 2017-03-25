//
//  ViewController.h
//  2-1-11
//
//  Created by yuu ogasawara on 2017/03/23.
//  Copyright © 2017年 stv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property NSArray *devices;
@end

@interface ViewController (UITableViewDataSource)<UITableViewDataSource>

@end
