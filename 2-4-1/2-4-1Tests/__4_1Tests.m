//
//  __4_1Tests.m
//  2-4-1Tests
//
//  Created by yuu ogasawara on 2017/04/07.
//  Copyright © 2017年 stv. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AFNetworking.h"
#import "NSString+decodeJSONString.h"
#import "WeatherForecastFetcher.h"
#import "WeatherForecastConnector.h"
#import "WeatherForecastManager.h"
#import "Const.h"
#import "NSString+DateFormat.h"
#import "DaoWeatherForecasts.h"

//NSString* const kColumnNameForecastDate = @"forecast_date";
//NSString* const kColumnNameForecastWeather = @"forecast_weather";
//NSString* const kColumnNameImageURL = @"image_url";
//
@interface __4_1Tests : XCTestCase<WeatherForecastFetcherDelegate>
@property XCTestExpectation* expectation;
@property WeatherForecastConnector* connector;
@end

@implementation __4_1Tests
#pragma mark setting & clean up
- (void)setUp {
    [super setUp];
    
    DaoWeatherForecasts* dao = [DaoWeatherForecasts shared];
    [dao removeAllRecordIn:test];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    
    [self.connector.retrieveFetchers removeAllObjects];
    
    DaoWeatherForecasts* dao = [DaoWeatherForecasts shared];
    [dao removeAllRecordIn:test];
}

#pragma mark fetcher test
- (void)testFetchWeatherInfo{
    WeatherForecastFetcher* fetcher = [[WeatherForecastFetcher alloc] initWithURL:kWeatherReportAPIBaseURL];
    fetcher.delegate = self;

    self.expectation = [self expectationWithDescription:@"CallWeatherFetchDelegate"];
    
    NSDictionary<NSString*,NSString*> *queryParam = @{@"city":@"130010"};
    [fetcher fetchWeatherForecastOn:queryParam];
    
    [self waitForExpectationsWithTimeout:120
                                 handler:^(NSError * _Nullable error){
        if (error != nil) {
            NSLog(@"%@",error.description);
            XCTFail();
        }
    }];
    
}
#pragma mark WeatherFerecastFetcherDelegate

/**
 通信がうまく行ったら呼ばれる。
 
 @param fetcher parsedDictinaryプロパティに、通信結果がパースされて詰まっているはず
 */
-(void)fetcherDidFinishFetching:(WeatherForecastFetcher *)fetcher{
    //MEMO: 非同期処理の監視を終了（タイムアウトまでに、この行に達しなかったらハンドラが実行される）
    [self.expectation fulfill];
    
    //通信結果を確認
    NSString* weatherInfoString  = fetcher.parsedDictionary.description;
    XCTAssertNotNil(weatherInfoString);
}


/**
 通信が失敗したら呼ばれる。
 
 @param fetcher 通信が失敗したフェッチャー
 @param error エラーの内容
 */
-(void)fetcher:(WeatherForecastFetcher *)fetcher
didFailWithError:(NSError *)error{
    [self.expectation fulfill];
    
    if (error != nil) {
        NSLog(@"An error has happened. description:%@",error.description);
    }
    
}

#pragma mark connector test
/**
 connectorが正しくAPIの情報を取ってくることができるか、通信エラーを出すことを確認。
 なお、connectorがfetchWeatherForecastFrom:を実行した際は、
 ・通信が成功した場合、expectationForNotification:のハンドラが呼ばれる
 ・通信が失敗した場合、connectorDidFailFetching:メソッドが呼ばれる
 ・connector・fetcherからのコールバックがない場合、waitForExpectationsWithTimeout:メソッドのハンドラが呼ばれる
 */
- (void)testConnectorToFetch{
    [self.expectation fulfill];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(connectorDidFailFetching:)
                                                 name:kConnectorDidFailFetchWeatherForecast
                                               object:nil];

    self.connector = [WeatherForecastConnector sharedConnector];
    
    XCTAssertFalse(self.connector.isNetworkAccessing);
    XCTAssertFalse(self.connector.isFetchingWeatherForecast);
    
    [self.connector fetchWeatherForecastFrom:kWeatherReportAPIBaseURL];

    [self expectationForNotification:kConnectorDidFinishFetchWeatherForecast
                              object:nil
                             handler:^BOOL(NSNotification *notification){
                                 
                                 NSDictionary* parsedDictionary = notification.userInfo;
                                 NSString* weatherSummaryString = parsedDictionary[@"description"][@"text"];
                                 NSArray<NSDictionary*>* forecasts = parsedDictionary[@"forecasts"];
                                 
                                 XCTAssertNotNil(weatherSummaryString);
                                 XCTAssertNotNil(forecasts);
                                 
                                 NSLog(@"%@",parsedDictionary);
                                 NSLog(@"summary is %@",weatherSummaryString.decodeJSONString);
                                 NSLog(@"forecasts are %@",forecasts.description.decodeJSONString);
                                 
                                 [[NSNotificationCenter defaultCenter] removeObserver:self];
                                 
                                 return YES;
                             }];
    
    
    [self waitForExpectationsWithTimeout:20.0
                                 handler:^(NSError *error){
                                     
                                     NSLog(@"%s, %@",__func__,error.localizedDescription);
                                     [[NSNotificationCenter defaultCenter] removeObserver:self];
                                 }];
}

//通信エラーで返ってきたとき
-(void)connectorDidFailFetching:(NSNotification*)notification{
    [self.expectation fulfill];
    
    NSError *error = notification.userInfo[@"error"];
    NSLog(@"%s, %@",__func__,error.localizedDescription);
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//JSONをパースしたものを正しくモデルに詰め替えることができているか
- (void)testComposeForecastsModel{
    //JSONデータをパースしたものを用意する
    NSError *error0 = nil;
    NSBundle* bundle = [NSBundle mainBundle];
    NSString* path = [bundle pathForResource:@"v1"
                                      ofType:@"json"];
    NSString* jsonString = [[NSString alloc] initWithContentsOfFile:path
                                                           encoding:NSUTF8StringEncoding
                                                              error:&error0];
    NSData* jsonData = [jsonString dataUsingEncoding:NSUnicodeStringEncoding];
    
    if (error0) {
        NSLog(@"読み込みエラー");
        return;
    }
    
    NSError *error1 = nil;
    NSDictionary* parsedDictionary = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                   options:NSJSONReadingAllowFragments error:&error1];
    if(error1){
        NSLog(@"パースエラー");
    }
    
    //パースしたデータから必要なところだけ取り出す
    NSArray<NSDictionary*>* forecastsRowData = parsedDictionary[@"forecasts"];
    NSLog(@"forecastsRowData are %@",forecastsRowData.description.decodeJSONString);
    
    //Managerクラスに変換させる
    NSArray<WeatherForecast*>* forecastArray = [[WeatherForecastManager sharedManager] composeForecastsFrom:forecastsRowData];
    
    XCTAssertNotNil(forecastArray);
    XCTAssertNotEqual(forecastArray.count, 0);
    
    XCTAssertEqual(forecastArray.count, forecastsRowData.count);
    
    //モデルクラスの配列forecastArrayの各要素について、変換前のデータと比較する
    [forecastArray enumerateObjectsUsingBlock:^(WeatherForecast* forecast, NSUInteger index, BOOL *stop){
        
        //日時の比較(辞書には文字列で入っているので、タイムゾーンがGMTのNSDateに変換して比較する
        NSDictionary* forecastDict = forecastsRowData[index];
        NSString* dateString = forecastDict[@"date"];

        XCTAssertEqualObjects(forecast.date, [dateString dateObject]);

        //image URLの比較
        NSString *dictURL = forecastDict[@"image"][@"url"];
        XCTAssertEqualObjects(forecast.weatherImage.imageURL, dictURL);
        
        //天気の比較
        XCTAssertEqualObjects(forecast.telop, forecastDict[@"telop"]);

        //温度の比較
        XCTAssertEqual(forecast.maxTemprature, [forecastDict[@"temerature"][@"max"][@"celsius"] integerValue]);
        XCTAssertEqual(forecast.minTemprature, [forecastDict[@"temerature"][@"min"][@"celsius"] integerValue]);
        
        //最後の要素に来たら、終了フラグを立てないと終了できない
        if (index == forecastArray.count) {
            *stop = YES;
        }
    }];
}

#pragma mark DB I/O
- (void)testInsertRecordToDB{
    //保存したいモデルを作る
    WeatherRecord* weatherRecord = @{kColumnNameForecastDate:@"2017-04-18",
                                     kColumnNameForecastWeather:@"曇り",
                                     kColumnNameImageURL:@"example.com"
                                     };
    
    //保存するメソッドを呼ぶ
    DaoWeatherForecasts* dao = [[DaoWeatherForecasts alloc] initForTest];
    XCTAssertNotNil([dao addRecord:weatherRecord to:test]);
    
    //取り出してくる
    NSArray<WeatherRecord*>* weatherRecords = [dao weatherForecastsFrom:test];
    
    //比較する
    for (WeatherRecord* weatherRecord in weatherRecords) {
        XCTAssertEqualObjects(weatherRecord[kColumnNameForecastDate], @"2017-04-18");
        XCTAssertEqualObjects(weatherRecord[kColumnNameForecastWeather], @"曇り");
        XCTAssertEqualObjects(weatherRecord[kColumnNameImageURL], @"example.com");
    }
}

#pragma mark performance test
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}



@end
