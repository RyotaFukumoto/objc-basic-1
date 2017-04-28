//
//  __6_2Tests.m
//  2-6-2Tests
//
//  Created by yuu ogasawara on 2017/04/27.
//  Copyright © 2017年 stv. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+dictionaryFromQueryString.h"

@interface __6_2Tests : XCTestCase

@end

@implementation __6_2Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

/**
 クエリ文字列から、NSDictionaryが生成できているかテスト
 例：@"title=paths_of_glory&key=year"から@{@"title":@"paths_of_glory",@"key":@"year"}ができている
 キー、値中の"+"は半角スペースに置き換えている
 */
- (void)testDictionaryFormQueryString{
    NSString *query = @"title=paths_of_glory&key=year";
    NSDictionary *queryDic = [query dictionaryFromQueryString];
    
    //クエリから生成した辞書にtitleキーとkeyキーがあることを確認
    XCTAssertTrue([queryDic.allKeys containsObject:@"title"]);
    XCTAssertTrue([queryDic.allKeys containsObject:@"key"]);
    
    //キーと値がクエリ文字列と一致することを確認
    XCTAssertEqualObjects(queryDic[@"title"], @"paths_of_glory");
    XCTAssertEqualObjects(queryDic[@"key"], @"year");
    
    
    //値に=が含まれている場合
    NSString *query2 = @"title=paths=glory&key=year";
    NSDictionary *queryDic2 = [query2 dictionaryFromQueryString];
    
    XCTAssertTrue([queryDic2.allKeys containsObject:@"title"]);
    XCTAssertTrue([queryDic2.allKeys containsObject:@"key"]);
    
    XCTAssertEqualObjects(queryDic2[@"title"], @"paths=glory");
    XCTAssertEqualObjects(queryDic2[@"key"], @"year");
    
    //key/val に + があった場合
    NSString *query3 = @"ti+tle=paths=glory&key=ye+ar";
    NSDictionary *queryDic3 = [query3 dictionaryFromQueryString];
    
    XCTAssertTrue([queryDic3.allKeys containsObject:@"ti tle"]);
    XCTAssertTrue([queryDic3.allKeys containsObject:@"key"]);
    
    XCTAssertEqualObjects(queryDic3[@"ti tle"], @"paths=glory");
    XCTAssertEqualObjects(queryDic3[@"key"], @"ye ar");
}

//- (void)testPerformanceExample {
//    // This is an example of a performance test case.
//    [self measureBlock:^{
//        // Put the code you want to measure the time of here.
//    }];
//}

@end
