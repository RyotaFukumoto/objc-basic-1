//
//  ToDoListViewController+UITableViewDelegate.m
//  2-3-2
//
//  Created by yogasawara@stv on 2017/04/07.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "ToDoListViewController+UITableViewDelegate.h"

@implementation ToDoListViewController (UITableViewDelegate)

/**
 セルの削除の際に、DBの該当するレコードも削除する

 @param tableView 操作中のテーブルビュー
 @param editingStyle 編集モード
 @param indexPath セルの位置
 @return YES
 */
-(BOOL)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //データを更新（削除フラグを立てる）
        ToDo* todo = self.todos[indexPath.row];
        [self.daoToDos deleteToDoOf:todo.todoID];
        
        //表の再描画
        self.todos = [NSMutableArray arrayWithArray:[self.daoToDos todos]];
        [self.tableView reloadData];
    }
    
    return YES;
}
@end
