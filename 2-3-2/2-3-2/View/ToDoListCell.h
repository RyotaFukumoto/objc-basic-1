//
//  ToDoListCell.h
//  2-3-2
//
//  Created by yuu ogasawara on 2017/04/05.
//  Copyright © 2017年 stv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDo.h"

@interface ToDoListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *expirationDateLabel;
+ (NSString*)className;
- (void)setCell:(ToDo*)todo;
@end
