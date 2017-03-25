//
//  ViewController+UITableViewDataSource.m
//  2-1-10
//
//  Created by yuu ogasawara on 2017/03/23.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController (UITableViewDataSource)
-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section{
    NSArray *members = [self callMembers];
    return members.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *reuseIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    NSArray *members = [self callMembers];
    Member *member = members[indexPath.row];
    
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:1];
    nameLabel.text = member.name;
    nameLabel.font = [UIFont boldSystemFontOfSize:30];
    
    UIImage* image = [UIImage imageNamed:member.name];
    UIImageView *iv = (UIImageView *)[cell viewWithTag:2];
    iv.image = image;
    
    UILabel *explanationLabel = (UILabel *)[cell viewWithTag:3];
    explanationLabel.text = member.explanation;
    
    return cell;
}

-(NSArray*)callMembers
{
    TwoAnyOneManager* manager = [TwoAnyOneManager new];
    return manager.members;
}
@end
