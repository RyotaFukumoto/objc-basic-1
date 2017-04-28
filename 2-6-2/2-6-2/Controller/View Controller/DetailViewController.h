//
//  DetailViewController.h
//  2-6-2
//
//  Created by yuu ogasawara on 2017/04/27.
//  Copyright © 2017年 stv. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
@property IBOutlet UILabel* titleLabel;
@property IBOutlet UILabel* keyLabel;
@property IBOutlet UILabel* valueLabel;
@property NSDictionary<NSString*,NSString*>* query;

-(BOOL)configureView:(NSDictionary<NSString*,NSString*>*)query;
@end
