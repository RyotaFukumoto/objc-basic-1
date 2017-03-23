//
//  ViewController+TableViewDelegate.m
//  2-1-10
//
//  Created by yuu ogasawara on 2017/03/23.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController (TableViewDelegate)


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.devices.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *devicesArray = self.devices[section];
    return devicesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *reuseIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    NSArray *devicesArray = self.devices[indexPath.section];
    NSDictionary *deviceDic = devicesArray[indexPath.row];
    
    //名前
    NSString *name = deviceDic[@"name"];
    
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:1];
    nameLabel.text = name;
    nameLabel.font = [UIFont boldSystemFontOfSize:30];

    //詳細情報
    NSMutableString *description = [NSMutableString string];
    
    //画面サイズ 例："size:9.7inch"
    NSNumber *displaySize = deviceDic[@"size"];
    //小数点以下第一位まで表示するように設定する　参考:http://program.station.ez-net.jp/special/handbook/objective-c/datatype/format-number.asp
    NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    formatter.maximumFractionDigits = 1;
    NSString* string = [formatter stringFromNumber:displaySize];

    NSString *sizeString = [NSString stringWithFormat:@"size:%@inch\n",string];
    [description appendString:sizeString];
    
    //容量 例："capacity:32,64GB"
    NSArray<NSNumber*> *capacityArray = deviceDic[@"capacity"];
    NSMutableString *capacityString = [NSMutableString stringWithFormat:@"capacity:"];
    
    for (NSNumber *capacity in capacityArray) {
        [capacityString appendString:[capacity stringValue]];
        [capacityString appendString:@","];
    }
    
    NSUInteger capacityStringLength = [capacityString length];
    NSString *str = [capacityString substringToIndex:capacityStringLength-1];
    NSString *str2 = [str stringByAppendingString:@"GB"];
    [description appendString:str2];
    
    UIImage* image = [UIImage imageNamed:name];
    UIImageView *iv = (UIImageView *)[cell viewWithTag:2];
    iv.image = image;
    
    UILabel *descriptionLabel = (UILabel *)[cell viewWithTag:3];
    descriptionLabel.text = description;
    
    return cell;
}
@end
