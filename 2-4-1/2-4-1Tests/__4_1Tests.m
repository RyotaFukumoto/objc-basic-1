//
//  __4_1Tests.m
//  2-4-1Tests
//
//  Created by yuu ogasawara on 2017/04/07.
//  Copyright © 2017年 stv. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AFNetworking.h"
#import "WeatherForecastFetcher.h"
#import "NSString+decodeJSONString.h"

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

#pragma mark test
- (void)testFetchWeatherInfo{
    WeatherForecastFetcher* fetcher = [[WeatherForecastFetcher alloc] initWithURL:@"http://weather.livedoor.com/forecast/webservice/json/v1?city=130010"];
    fetcher.delegate = self;

    self.expectation = [self expectationWithDescription:@"CallWeatherFetchDelegate"];
    
    [fetcher fetchWeatherForecast];
    [self waitForExpectationsWithTimeout:60 handler:^(NSError * _Nullable error){
        XCTAssertNil(error,@"has error.");
    }];
    
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
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
 通信が失敗したら呼ばれる。かならずアサートを出すようにしてある。

 @param fetcher 通信が失敗したフェッチャー
 @param error エラーの内容
 */
-(void)fetcher:(WeatherForecastFetcher *)fetcher
didFailWithError:(NSError *)error{
    [self.expectation fulfill];
    XCTFail(@"%@",error);
}

@end
