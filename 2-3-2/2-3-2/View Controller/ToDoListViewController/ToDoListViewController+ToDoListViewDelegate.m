//
//  ToDoListViewController+ToDoListViewDelegate.m
//  2-3-2
//
//  Created by yuu ogasawara on 2017/04/06.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "ToDoListViewController+ToDoListViewDelegate.h"

@implementation ToDoListViewController (ToDoListViewDelegate)
-(void)createdNewTask{
    //データの更新
    [self reloadData];
    //表の再描画
    [self.tableView reloadData];
    
    //画面を閉じる
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)reloadData{
    self.todos = [NSMutableArray arrayWithArray:[self.daoToDos todos]];
}
@end
