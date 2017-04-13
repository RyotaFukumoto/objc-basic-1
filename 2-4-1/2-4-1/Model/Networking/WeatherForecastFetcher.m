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


/**
 パラメタに基づいてLiveDoorのお天気情報API(URLはself.urlStringに依存）のクエリを生成、取得したJSONをパースしてデリゲート先に（自分ごと）渡す
 デリゲート先は、デリゲートメソッドのfetcher.urlStringを参照すればクエリ先を取得できる

 @param parameters {パラメタ名：値} ex: {"city":"410020"}
 */
-(void)fetchWeatherForecastOn:(NSDictionary*)parameters{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
    [manager GET:self.urlString parameters:parameters progress:nil
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
