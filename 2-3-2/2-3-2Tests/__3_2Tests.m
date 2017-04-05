//
//  __3_2Tests.m
//  2-3-2Tests
//
//  Created by yuu ogasawara on 2017/03/31.
//  Copyright © 2017年 stv. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DaoToDos.h"

@interface __3_2Tests : XCTestCase
@end

@implementation __3_2Tests
DaoToDos* daoToDos;

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    daoToDos = [[DaoToDos alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

//２−３−４　テーブルにタスクのレコードを追加
//正常な値をDBに入れて、DB側でidが発行されて返ってくるかを確認
- (void)testAddTask{
    ToDo* toDo = [[ToDo alloc] init];
    toDo.todo_title = @"買い物";
    toDo.todo_contents = @"卵、牛乳";
    
    //期限の日時は、完成形ではdate pickerからNSDateで渡ってくる
    //ここでは今から3日後のNSDateを作成して渡している
    toDo.limit_date = [NSDate dateWithTimeIntervalSinceNow:3*60*60];
    
    //ここでは、IDはない状態でDBに送って、IDがDBで正しく発行されているかを見ている
    //DBへの書き込みが成功した場合、IDが発行されたタスクオブジェクトが返ってくる
    //書き込みが失敗した場合、completedToDoにはNilが入っている
    ToDo *completedToDo = [daoToDos add:toDo];
    XCTAssertNotNil(completedToDo);
    NSLog(@"タスクのIDは%zdが発行されました",completedToDo.todo_id);
    //DB Browserでレコードが発行されているか、タイトル、コンテンツ、書式はあっているか確認のこと
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
