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
#import "ViewController.h"

@interface __4_1Tests : XCTestCase<WeatherForecastFetcherDelegate>
@property XCTestExpectation* expectation;
@end

@implementation __4_1Tests
#pragma mark setting & clean up
- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark fetcher test
- (void)testFetchWeatherInfo{
    WeatherForecastFetcher* fetcher = [[WeatherForecastFetcher alloc] initWithURL:kWeatherReportAPIURLForTokyo];
    fetcher.delegate = self;

    self.expectation = [self expectationWithDescription:@"CallWeatherFetchDelegate"];
    
    [fetcher fetchWeatherForecast];
    [self waitForExpectationsWithTimeout:60 handler:^(NSError * _Nullable error){
        if (error != nil) {
            NSLog(@"%@",error.description);
        }
        
        XCTFail(@"has error.");
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
    NSLog(@"parsedDictionary is %@",weatherInfoString.decodeJSONString);
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
    //TODO: 通知の登録と、解除を記述する。解除は、通知を受け取って呼ばれるメソッドで行う。
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(connectorDidFailFetching:)
                                                 name:WeatherForecastConnectorDidFailFetchWeatherForecast
                                               object:nil];
    self.expectation = [self expectationWithDescription:@"CallConnector,possible to fail"];

    WeatherForecastConnector* connector = [WeatherForecastConnector sharedConnector];
    
    XCTAssertFalse(connector.isNetworkAccessing);
    XCTAssertFalse(connector.isFetchingWeatherForecast);
    
    [self expectationForNotification:WeatherForecastConnectorDidFinishFetchWeatherForecast
                              object:nil
                             handler:^BOOL(NSNotification *notification){
                                 NSDictionary* parsedDictionary = notification.userInfo;
                                 NSString* weatherSummaryString = parsedDictionary[@"description"][@"text"];
                                 NSArray<NSDictionary*>* forecasts = parsedDictionary[@"forecasts"];
                                 
                                 XCTAssertNotNil(weatherSummaryString);
                                 XCTAssertNotNil(forecasts);
                                 
                                 NSLog(@"summary is %@",weatherSummaryString.decodeJSONString);
                                 NSLog(@"forecasts are %@",forecasts.description.decodeJSONString);
                                 
                                 [[NSNotificationCenter defaultCenter] removeObserver:self];
                                 
                                 [self.expectation fulfill];
                                 return YES;
                             }];
    
    [connector fetchWeatherForecastFrom:kWeatherReportAPIURLForTokyo];
    
    [self waitForExpectationsWithTimeout:30.0
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

#pragma mark performance test
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}



@end
