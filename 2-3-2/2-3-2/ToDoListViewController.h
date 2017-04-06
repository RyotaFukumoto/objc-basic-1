//
//  ToDoListViewController.h
//  2-3-2
//
//  Created by yuu ogasawara on 2017/04/04.
//  Copyright © 2017年 stv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DaoToDos.h"
#import "ToDoListCell.h"

@interface ToDoListViewController : UIViewController{
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) DaoToDos*         daoToDos;
@property (nonatomic) NSMutableArray*   todos;
@end

