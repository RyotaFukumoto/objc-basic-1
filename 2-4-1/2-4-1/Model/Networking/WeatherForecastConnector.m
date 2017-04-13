//
//  WeatherForecastConnector.m
//  2-4-1
//
//  Created by yogasawara@stv on 2017/04/10.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "WeatherForecastConnector.h"

NSString* const kConnectorDidFinishFetchWeatherForecast = @"kConnectorDidFinishFetchWeatherForecast";
NSString* const kConnectorDidFailFetchWeatherForecast = @"kConnectorDidFailFetchWeatherForecast";

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
    
    NSDictionary<NSString*,NSString*> *queryParam = @{@"city":@"130010"};
    [fetcher fetchWeatherForecastOn:queryParam];
    
    [self.retrieveFetchers addObject:fetcher];
}

#pragma mark WeatherForecastFetcherDelegate

/**
 通知のuserInfoが、JSONをパースしたものになる。

 @param fetcher パースが完了したフェッチャー
 */
-(void)fetcherDidFinishFetching:(WeatherForecastFetcher *)fetcher{
    NSDictionary* dictionary = fetcher.parsedDictionary;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kConnectorDidFinishFetchWeatherForecast
                                                        object:self
                                                      userInfo:dictionary];
    
    [self release:fetcher];
}

-(void)fetcher:(WeatherForecastFetcher *)fetcher
didFailWithError:(NSError *)error{
    NSDictionary* userInfo = @{@"error":error};
    [[NSNotificationCenter defaultCenter] postNotificationName:kConnectorDidFailFetchWeatherForecast
                                                        object:self
                                                      userInfo:userInfo];
    
    [self release:fetcher];
}

-(void)release:(WeatherForecastFetcher*)fetcher{
    if (self.retrieveFetchers.count == 0){
        return;
    }
         
    for (WeatherForecastFetcher* fetcherInArray in self.retrieveFetchers) {
        if (fetcherInArray == fetcher) {
            [self.retrieveFetchers removeObject:fetcherInArray];
            return;
        }
    }
}
@end
