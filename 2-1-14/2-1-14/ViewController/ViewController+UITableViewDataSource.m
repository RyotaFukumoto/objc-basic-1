//
//  ViewController+UITableViewDataSource.m
//  2-1-14
//
//  Created by yuu ogasawara on 2017/03/23.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController (UITableViewDataSource)
-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section{
    NSArray<Member*> *members = [self callMembers];
    return members.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *reuseIdentifier = @"Cell";
    TATableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    NSArray<Member*> *members = [self callMembers];
    Member *member = members[indexPath.row];
    
    cell.nameLabel.text = member.name;
    
    UIImage* image = [UIImage imageNamed:member.name];
    cell.portraitView.image = image;

    cell.explainLabel.text = member.explanation;
    
    return cell;
}

-(NSArray<Member*>*)callMembers
{
    TwoAnyOneManager* manager = [TwoAnyOneManager new];
    return manager.members;
}
@end
