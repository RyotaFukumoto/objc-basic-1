//
//  ToDoListViewController+UITableViewDataSource.m
//  2-3-2
//
//  Created by yuu ogasawara on 2017/04/05.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "ToDoListViewController+UITableViewDataSource.h"
#import "ToDoListCell.h"
#import "DateTrimmer.h"

@implementation ToDoListViewController (UITableViewDataSource)

-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section
{
    return self.todos.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ToDoListCell* cell = [tableView dequeueReusableCellWithIdentifier:[ToDoListCell className]
                          forIndexPath:indexPath];
    
    ToDo* todo = self.todos[indexPath.row];
    cell.titleLabel.text = todo.todoTitle;
    cell.expirationDateLabel.text = [DateTrimmer systemDateString:todo.limitDate];
    
    return cell;
}

@end
