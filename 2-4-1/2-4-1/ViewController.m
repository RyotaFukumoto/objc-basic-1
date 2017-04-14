//
//  ViewController.m
//  2-4-1
//
//  Created by yuu ogasawara on 2017/04/07.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "NSString+decodeJSONString.h"
#import "Const.h"
#import "WeatherForecastDataSource.h"
#import "WeatherForecastCell.h"
#import "WeatherSummaryCell.h"
#import "WeatherForecastManager.h"
#import "DaoWeatherForecasts.h"

@interface ViewController ()
@property NSArray<NSDictionary*>* forecastsArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) WeatherForecastDataSource *dataSource;
@property (nonatomic) DaoWeatherForecasts* dao;
@end

@implementation ViewController
#pragma mark Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //事前にお天気情報を取得しておく
    //WeatherForecastManager* manager = [WeatherForecastManager sharedManager];
    //[manager callConnectorToFetchWeatherForecast];
    
    [self configureTableView];
    
    //APIからの取得が終わったときにTable Viewを再描画する。そのための準備
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(connectorDidFinishFetchWeatherForecast:)
                                                 name:kConnectorDidFinishFetchWeatherForecast
                                               object:[WeatherForecastConnector sharedConnector]];
    
    self.dao = [DaoWeatherForecasts shared];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 Connectorクラスの天気予報取得が完了すると呼ばれる。
 
 @param notification パース済みの天気予報APIからのレスポンス
 */
- (void)connectorDidFinishFetchWeatherForecast:(NSNotification*)notification{
    [self.tableView reloadData];
}

/**
 テーブルビューの初期設定をする
 */
- (void)configureTableView{
    //事前にお天気情報を取得しておく
    WeatherForecastManager* manager = [WeatherForecastManager sharedManager];
    [manager callConnectorToFetchWeatherForecast];
    
    //TableViewの表示のための設定
    [self.tableView registerNib:[UINib nibWithNibName:[WeatherSummaryCell className]
                                               bundle:nil]
         forCellReuseIdentifier:[WeatherSummaryCell className]];
    
    [self.tableView registerNib:[UINib nibWithNibName:[WeatherForecastCell className]
                                               bundle:nil]
         forCellReuseIdentifier:[WeatherForecastCell className]];
    
    self.dataSource = [[WeatherForecastDataSource alloc] init];
    self.tableView.dataSource = self.dataSource;
    
    ///セルの高さを可変にする
    ///参考：http://tomoyaonishi.hatenablog.jp/entry/2014/09/27/161152
    self.tableView.estimatedRowHeight = 150.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}
@end
