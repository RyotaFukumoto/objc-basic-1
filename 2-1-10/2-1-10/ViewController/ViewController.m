//
//  ViewController.m
//  2-1-10
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
    
    //Load data form plist
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"2NE1" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    self.members = (NSArray *)[dic objectForKey:@"Name"];
    self.descriptions = (NSArray *)[dic objectForKey:@"Description"];
    
    ///セルの高さを可変にする
    ///参考：http://tomoyaonishi.hatenablog.jp/entry/2014/09/27/161152
    self.tableView.estimatedRowHeight = 150.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
