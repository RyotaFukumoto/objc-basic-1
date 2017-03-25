//
//  ViewController+UITableViewDataSource.m
//  2-1-10
//
//  Created by yuu ogasawara on 2017/03/23.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController (UITableViewDataSource)
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.appleDeviceArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section
{
    NSArray *deviceArray = self.appleDeviceArray[section];
    return deviceArray.count;
}

-(NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return @"iPhone";
            break;
        case 1:
            return @"iPad";
            break;
        default:
            return @"Others";
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *reuseIdentifier = @"Cell";
    DeviceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    NSArray *deviceArray = self.appleDeviceArray[indexPath.section];
    Device *device = deviceArray[indexPath.row];
    
    //名前
    NSString *name = device.name;

    //詳細情報
    NSMutableString *description = [NSMutableString string];
    
    //画面サイズ 例："size:9.7inch"
    NSNumber *displaySize = device.size;
    //小数点以下第一位まで表示するように設定する　参考:http://program.station.ez-net.jp/special/handbook/objective-c/datatype/format-number.asp
    NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    formatter.maximumFractionDigits = 1;
    NSString* string = [formatter stringFromNumber:displaySize];

    NSString *sizeString = [NSString stringWithFormat:@"size:%@inch\n",string];
    [description appendString:sizeString];
    
    //容量 例："capacity:32,64GB"
    NSArray<NSNumber*> *capacityArray = device.capacity;
    NSMutableString *capacityString = [NSMutableString stringWithFormat:@"capacity:"];
    
    for (NSNumber *capacity in capacityArray) {
        [capacityString appendString:[capacity stringValue]];
        [capacityString appendString:@","];
    }
    //最後についている「,」を削除して末尾に「GB」を付け足す
    NSUInteger capacityStringLength = [capacityString length];
    NSString *str = [capacityString substringToIndex:capacityStringLength-1];
    NSString *str2 = [str stringByAppendingString:@"GB"];
    [description appendString:str2];
    
    //その他特記事項
    if (device.notices != nil) {
        [description appendString:[NSString stringWithFormat:@"\n%@",device.notices]];
    }
    
    //UIパーツに設定
    cell.nameLabel.text = name;
    cell.nameLabel.font = [UIFont boldSystemFontOfSize:30];
    
    UIImage* image = [UIImage imageNamed:name];
    cell.photoView.image = image;
    
    cell.explainLabel.text = description;
    
    return cell;
}
@end
