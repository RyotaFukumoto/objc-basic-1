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

NSInteger const numberOfSection = 1;

@implementation ToDoListViewController (UITableViewDataSource)

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return numberOfSection;
}

-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section
{
    self.todos = [NSMutableArray arrayWithArray:[self.daoToDos todos]];
    return self.todos.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* CellIdentifier = @"MyCell";
    
    ToDoListCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    self.todos = [NSMutableArray arrayWithArray:[self.daoToDos todos]];
    ToDo* todo = self.todos[indexPath.row];
    cell.titleLabel.text = todo.todo_title;
    cell.expirationDateLabel.text = [DateTrimmer systemDateString:todo.limit_date];
    
    return cell;
}

@end
