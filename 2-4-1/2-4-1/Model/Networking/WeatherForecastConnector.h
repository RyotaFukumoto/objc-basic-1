//
//  WeatherForecastConnector.h
//  2-4-1
//
//  Created by yogasawara@stv on 2017/04/10.
//  Copyright © 2017年 stv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherForecastFetcher.h"

extern NSString* const kConnectorDidFinishFetchWeatherForecast;
extern NSString* const kConnectorDidFailFetchWeatherForecast;

@interface WeatherForecastConnector : NSObject<WeatherForecastFetcherDelegate>
@property NSMutableArray<WeatherForecastFetcher*> *retrieveFetchers;
@property (readonly) BOOL isFetchingWeatherForecast;
@property (readonly) BOOL isNetworkAccessing;

+ (WeatherForecastConnector*)sharedConnector;
-(void)fetchWeatherForecastFrom:(NSString*)urlString;
@end
