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
#import "WeatherTableView.h"

@interface ViewController ()
@property NSArray<NSDictionary*>* forecastsArray;
@property (weak, nonatomic) IBOutlet WeatherTableView *weatherTableView;
@property (nonatomic) WeatherForecastDataSource *dataSource;
@property (nonatomic) DaoWeatherForecasts* dao;
@end

@implementation ViewController
#pragma mark Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dao = [DaoWeatherForecasts shared];

    //事前にお天気情報を取得しておく
    WeatherForecastManager* manager = [WeatherForecastManager sharedManager];
    [manager callConnectorToFetchWeatherForecast];
    
    [self.weatherTableView configureView];
    
    //APIからの取得が終わったときにTable Viewを再描画する。そのための準備
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(connectorDidFinishFetchWeatherForecast:)
                                                 name:kConnectorDidFinishFetchWeatherForecast
                                               object:[WeatherForecastConnector sharedConnector]];
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
    [self.weatherTableView reloadData];
}
@end
