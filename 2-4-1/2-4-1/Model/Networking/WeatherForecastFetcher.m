//
//  WeatherForecastFetcher.m
//  2-4-1
//
//  Created by yogasawara@stv on 2017/04/10.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "WeatherForecastFetcher.h"
#import "AFNetworking.h"

@implementation WeatherForecastFetcher
#pragma mark initializer
-(WeatherForecastFetcher*)initWithURL:(NSString*)urlString{
    self = [super init];
    
    if (self != nil) {
        self.urlString = urlString;
    }
    
    return self;
}

-(WeatherForecastFetcher *)initWithURL:(NSString *)urlString delegate:(id)delegate{
    self = [super init];
    
    if (self != nil){
        self.urlString = urlString;
        self.delegate = delegate;
    }
    
    return self;
}

-(void)fetchWeatherForecast{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:self.urlString parameters:nil progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             // json取得に成功した場合の処理
             //responseObjectはNSDictionary型
             self.parsedDictionary = (NSDictionary*)responseObject;
             
             if ([self.delegate respondsToSelector:@selector(fetcherDidFinishFetching:)]) {
                 [self.delegate fetcherDidFinishFetching:self];
             }
         }
     
         failure:^(NSURLSessionTask *operation, NSError *error) {
             // エラーの場合の処理
             if ([self.delegate respondsToSelector:@selector(fetcher:didFailWithError:)]) {
                 [self.delegate fetcher:self didFailWithError:error];
             }
         }
     ];
}
@end
