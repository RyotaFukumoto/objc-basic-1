//
//  ToDoDetailViewController.h
//  2-3-2
//
//  Created by yuu ogasawara on 2017/04/04.
//  Copyright © 2017年 stv. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ToDoDetailViewDelegate <NSObject>

-(void)createdNewTask;

@end

@interface ToDoDetailViewController : UIViewController<UITextFieldDelegate>
@property (weak) id<ToDoDetailViewDelegate> delegate;
+ (NSString*)className;

@end

