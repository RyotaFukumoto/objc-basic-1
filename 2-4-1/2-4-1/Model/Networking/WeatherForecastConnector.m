//
//  WeatherForecastConnector.m
//  2-4-1
//
//  Created by yogasawara@stv on 2017/04/10.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "WeatherForecastConnector.h"

NSString* const WeatherForecastConnectorDidFinishFetchWeatherForecast = @"WeatherForecastConnectorDidFinishFetchWeatherForecast";
NSString* const WeatherForecastConnectorDidFailFetchWeatherForecast = @"WeatherForecastConnectorDidFailFetchWeatherForecast";

@implementation WeatherForecastConnector

static WeatherForecastConnector *_sharedInstance = nil;

#pragma mark singleton
+(WeatherForecastConnector *)sharedConnector{
    if(!_sharedInstance){
        _sharedInstance = [[WeatherForecastConnector alloc] init];
    }
    
    return _sharedInstance;
}

#pragma mark state
-(BOOL)isFetchingWeatherForecast{
    return self.retrieveFetchers.count > 0;
}

-(BOOL)isNetworkAccessing{
    return self.retrieveFetchers.count > 0;
}

#pragma mark fetch Weather Forecast
-(void)fetchWeatherForecastFrom:(NSString *)urlString{
    if (self.isFetchingWeatherForecast) {
        return;
    }
    
    WeatherForecastFetcher* fetcher = [[WeatherForecastFetcher alloc] initWithURL:urlString
                                                                         delegate:self];
    [fetcher fetchWeatherForecast];
    
    [self.retrieveFetchers addObject:fetcher];
}

#pragma mark WeatherForecastFetcherDelegate
-(void)fetcherDidFinishFetching:(WeatherForecastFetcher *)fetcher{
    NSDictionary* dictionary = fetcher.parsedDictionary;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:WeatherForecastConnectorDidFinishFetchWeatherForecast
                                                        object:self
                                                      userInfo:dictionary];
    
    //処理が完了したので、保持をなくす
    for (WeatherForecastFetcher* fetcherInArray in self.retrieveFetchers) {
        if (fetcherInArray == fetcher) {
            [self.retrieveFetchers removeObject:fetcherInArray];
            return;
        }
    }
}

-(void)fetcher:(WeatherForecastFetcher *)fetcher
didFailWithError:(NSError *)error{
    NSDictionary* userInfo = @{@"error":error};
    [[NSNotificationCenter defaultCenter] postNotificationName:WeatherForecastConnectorDidFailFetchWeatherForecast
                                                        object:self
                                                      userInfo:userInfo];
    
    //処理が完了したので、保持をなくす
    for (WeatherForecastFetcher* fetcherInArray in self.retrieveFetchers) {
        if (fetcherInArray == fetcher) {
            [self.retrieveFetchers removeObject:fetcherInArray];
            return;
        }
    }
}
@end
