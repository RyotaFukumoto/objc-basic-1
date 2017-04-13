//
//  WeatherForecastDataSource.m
//  2-4-1
//
//  Created by yogasawara@stv on 2017/04/11.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "WeatherForecastDataSource.h"
#import "WeatherForecastManager.h"
#import "WeatherSummaryCell.h"
#import "WeatherForecastCell.h"

typedef NS_ENUM(NSUInteger, Section){
    Summary = 0,
    DailyWeatherForecast
};

@implementation WeatherForecastDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

/**
 天気概要と、各日の天気の2つのセクションがある

 @param tableView 画面
 @param section 0なら天気概要、１なら各日の天気
 @return 天気概要のセクションは１、各日の天気ならAPIから取れただけの数を返す
 */
-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case Summary:
            return 1;
        case DailyWeatherForecast:{
            WeatherForecastManager* manager = [WeatherForecastManager sharedManager];
            return manager.forecasts.count;
        }
        default:
            return 0;
    }
}

/**
 セクションごとに、セルに情報を与えて、整ったものを返す

 @param tableView 表示されるテーブルビュー
 @param indexPath セクションが０か１かが、天気概要か各日の天気に対応
 @return セクションが０なら天気概要のセル、セクションが１なら各日の天気のセル
 */
-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WeatherForecastManager* manager = [WeatherForecastManager sharedManager];

    switch (indexPath.section) {
        case Summary:
        {
            WeatherSummaryCell* weatherSummaryCell = [tableView dequeueReusableCellWithIdentifier:[WeatherSummaryCell className]
                                                                                     forIndexPath:indexPath];
            [weatherSummaryCell setCellFor:manager.forecastSummary];
            return weatherSummaryCell;
        }
        case DailyWeatherForecast:{
            WeatherForecastCell* weatherForecastCell = [tableView dequeueReusableCellWithIdentifier:[WeatherForecastCell className]
                                                                                       forIndexPath:indexPath];
            
            [weatherForecastCell setCellFor:manager.forecasts[indexPath.row]];
            
            return weatherForecastCell;
        }
        default:{
            return nil;
        }
    }
}
@end
