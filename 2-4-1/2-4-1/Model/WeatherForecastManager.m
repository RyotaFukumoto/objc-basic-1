//
//  WeatherForecastManager.m
//  2-4-1
//
//  Created by yogasawara@stv on 2017/04/10.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "WeatherForecastManager.h"
#import "Const.h"
#import "NSString+DateFormat.h"

@interface WeatherForecastManager (){
    NSMutableArray<WeatherForecast*>* _forecasts;
    NSString* _forecastSummary;
}
@end

@implementation WeatherForecastManager


#pragma mark singleton, Life Cycle
static WeatherForecastManager* _sharedManager;

+(WeatherForecastManager *)sharedManager{
    if (!_sharedManager) {
        _sharedManager = [[WeatherForecastManager alloc] init];
        }
    
    return _sharedManager;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark accesser
-(NSString *)forecastSummary{
    return _forecastSummary;
}

-(NSArray<WeatherForecast *> *)forecasts{
    return _forecasts;
}

#pragma mark connector
- (void)callConnectorToFetchWeatherForecast{
    //コネクタが天気予報を取得した際の通知の登録
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(connectorDidFinishFetchWeatherForecast:)
                                                 name:kConnectorDidFinishFetchWeatherForecast
                                               object:nil];

    WeatherForecastConnector* connector = [WeatherForecastConnector sharedConnector];
    [connector fetchWeatherForecastFrom:kWeatherReportAPIBaseURL];
}

/**
 Connectorクラスの天気予報取得が完了すると呼ばれる

 @param notification パース済みの天気予報APIからのレスポンス
 */
- (void)connectorDidFinishFetchWeatherForecast:(NSNotification*)notification{
    //天気予報APIのレスポンス、JSONをパースしたもの
    NSDictionary* parsedDictionary = notification.userInfo;
    
    //天気予報の概要
    NSString* weatherSummaryString = parsedDictionary[@"description"][@"text"];
    _forecastSummary = weatherSummaryString;
        
    //各日の天気予報
    NSArray<NSDictionary*>* forecasts = parsedDictionary[@"forecasts"];
    
    _forecasts = [self composeForecastsFrom:forecasts];
    
}

//JSONをパースしたオブジェクトを、モデルクラスに詰め替える
-(NSMutableArray<WeatherForecast*>*)composeForecastsFrom:(NSArray<NSDictionary*>*)forecastsArray{
    NSMutableArray<WeatherForecast*>* forecastArray = [NSMutableArray array];
    
    for (NSDictionary* forecastDict in forecastsArray) {
        WeatherForecast* forecast = [[WeatherForecast alloc] init];
        
        NSDictionary* imageDictionary = forecastDict[@"image"];
        WeatherImage* weatherImage = [[WeatherImage alloc] init];
        weatherImage.imageURL = imageDictionary[@"url"];
        weatherImage.title = imageDictionary[@"title"];
        weatherImage.width = [imageDictionary[@"width"] integerValue];
        weatherImage.height = [imageDictionary[@"height"] integerValue];
        
        NSString* dateString = forecastDict[@"date"];
        forecast.date = [dateString dateObject];
        forecast.weatherImage = weatherImage;
        forecast.telop = forecastDict[@"telop"];
        forecast.maxTemprature = [forecastDict[@"temprature"][@"max"] integerValue];
        forecast.minTemprature = [forecastDict[@"temprature"][@"min"] integerValue];
        
        [forecastArray addObject:forecast];
    }
    
    return forecastArray;
}

@end
