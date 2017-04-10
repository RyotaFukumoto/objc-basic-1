//
//  WeatherForecastFetcher.h
//  2-4-1
//
//  Created by yogasawara@stv on 2017/04/10.
//  Copyright © 2017年 stv. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WeatherForecastFetcher;
@protocol WeatherForecastFetcherDelegate <NSObject>
- (void)fetcherDidFinishFetching: (WeatherForecastFetcher*)fetcher;
- (void)fetcher:(WeatherForecastFetcher*)fetcher didFailWithError:(NSError*)error;
@end

@interface WeatherForecastFetcher : NSObject
@property NSString* urlString;
@property NSDictionary* parsedDictionary;
@property (nonatomic,weak) id <WeatherForecastFetcherDelegate> delegate;
-(void)fetchWeatherForecast;
@end

