//
//  __3_1Tests.m
//  2-3-1Tests
//
//  Created by yuu ogasawara on 2017/03/31.
//  Copyright © 2017年 stv. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UserDefaultsManager.h"

@interface __3_1Tests : XCTestCase

@end

@implementation __3_1Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testUserDefaultsManager{
    ///データを保存してロードする処理が正しく作動していることを確認
    SaveData *saveData = [[SaveData alloc] initWithInt:3
                                                double:365
                                                string:@"test string"];
    UserDefaultsManager *userDefaultsManager = [[UserDefaultsManager alloc] init];
    [userDefaultsManager saveData:saveData];
    
    SaveData *loadedData = [userDefaultsManager loadData];
    
    XCTAssertEqual(saveData.integer, loadedData.integer);
    XCTAssertEqual(saveData.doubleNumber, loadedData.doubleNumber);
    
    //XCTAssertEqualはプリミティブ型にしか使えない。NSStringは別メソッドを呼ばないといけない。
    XCTAssertEqualObjects(saveData.string, loadedData.string);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
