//
//  ViewController+TableViewDelegate.m
//  2-1-10
//
//  Created by yuu ogasawara on 2017/03/23.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController (TableViewDelegate)
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.members.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *reuseIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    NSString *name = self.members[indexPath.row];
    NSString *description = self.descriptions[indexPath.row];
    
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:1];
    nameLabel.text = name;
    nameLabel.font = [UIFont boldSystemFontOfSize:30];
    
    UIImage* image = [UIImage imageNamed:name];
    UIImageView *iv = (UIImageView *)[cell viewWithTag:2];
    iv.image = image;
    
    UILabel *descriptionLabel = (UILabel *)[cell viewWithTag:3];
    descriptionLabel.text = description;
    
    return cell;
}
@end
