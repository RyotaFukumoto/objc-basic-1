//
//  DetailViewController.h
//  2-6-2
//
//  Created by yuu ogasawara on 2017/04/27.
//  Copyright © 2017年 stv. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ViewControllerBase.h"
#import "ViewControllerProtocol.h"

@interface DetailViewController : ViewControllerBase<ViewControllerProtocol>
@property IBOutlet UILabel* titleLabel;
@property IBOutlet UILabel* keyLabel;
@property IBOutlet UILabel* valueLabel;

@end
