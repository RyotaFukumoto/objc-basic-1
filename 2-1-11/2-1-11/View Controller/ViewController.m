//
//  ViewController.m
//  2-1-11
//
//  Created by yuu ogasawara on 2017/03/23.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    ///セルの高さを可変にする
    ///参考：http://tomoyaonishi.hatenablog.jp/entry/2014/09/27/161152
    self.tableView.estimatedRowHeight = 150.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray *)appleDeviceArray{
    NSArray *appleDeviceArray = [DeviceManager new].devices;
    return appleDeviceArray;
}

@end
