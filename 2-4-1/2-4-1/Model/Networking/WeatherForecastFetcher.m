//
//  WeatherForecastFetcher.m
//  2-4-1
//
//  Created by yogasawara@stv on 2017/04/10.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "WeatherForecastFetcher.h"
#import "AFNetworking.h"


//TODO:ちゃんとこの定義でデリゲートメソッドが動くのか？確認
//@interface句より前にプロトコルを定義したい、かつ引数に自分自身のインスタンスを含むメソッドを定義したい場合、空のプロトコル宣言をヘッダファイルに置き、自身のクラスを@class句で定義する必要がある。
//@class WeatherForecastFetcher;

//@protocol WeatherForecastFetcherDelegate <NSObject>
//@optional
//- (void)fetcherDidFinishFetching: (WeatherForecastFetcher*)fetcher;
//- (void)fetcher:(WeatherForecastFetcher*)fetcher didFailWithError:(NSError*)error;
//@end

@implementation WeatherForecastFetcher
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
             DLog(@"error");
         }
     ];
}
@end
