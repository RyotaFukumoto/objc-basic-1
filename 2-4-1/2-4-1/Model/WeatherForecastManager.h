//
//  WeatherForecastManager.h
//  2-4-1
//
//  Created by yogasawara@stv on 2017/04/10.
//  Copyright © 2017年 stv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherForecastConnector.h"
#import "WeatherForecast.h"

@interface WeatherForecastManager : NSObject
@property (nonatomic,readonly)NSArray<WeatherForecast*> *forecasts;
@property (nonatomic,readonly)NSString* forecastSummary;

+(WeatherForecastManager*)sharedManager;
-(void)callConnectorToFetchWeatherForecast;
-(NSMutableArray<WeatherForecast*>*)composeForecastsFrom:(NSArray<NSDictionary*>*)forecastsArray;
@end
