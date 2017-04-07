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
    daoToDos = [[DaoToDos alloc] initForTest];
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
    toDo.todoTitle = @"買い物";
    toDo.todoContents = @"卵、牛乳";
    
    //期限の日時は、完成形ではdate pickerからNSDateで渡ってくる
    //ここでは今から3日後のNSDateを作成して渡している
    toDo.limitDate = [NSDate dateWithTimeIntervalSinceNow:3*24*60*60];
    
    //ここでは、IDはない状態でDBに送って、IDがDBで正しく発行されているかを見ている
    //DBへの書き込みが成功した場合、IDが発行されたタスクオブジェクトが返ってくる
    //書き込みが失敗した場合、completedToDoにはNilが入っている
    ToDo *completedToDo = [daoToDos add:toDo
                                     to:test];
    XCTAssertNotNil(completedToDo);
    NSLog(@"タスクのIDは%zdが発行されました",completedToDo.todoID);
    //DB Browserでレコードが発行されているか、タイトル、コンテンツ、書式はあっているか確認のこと
}


/**
 DaoToDosクラスのtodosメソッドをテストしたいメソッド
 */
-(void)testFetchToDos{
    [daoToDos removeAllRecordIn:test];
    
    //モックデータを入れて同じデータが返ってくるかを見る
    //addメソッドで加えて出してくる
    NSMutableArray<ToDo*> *todoArray = [NSMutableArray array];
    
    for (int i = 1; i <5; i++) {
        ToDo* toDo = [[ToDo alloc] init];
        toDo.todoTitle = [NSString stringWithFormat:@"number%d",i];
        toDo.todoContents = [NSString stringWithFormat:@"number%d content",i];
        toDo.limitDate = [NSDate dateWithTimeIntervalSinceNow:i*60*60];
        [daoToDos add:toDo
                   to:test];
        [todoArray addObject:toDo];
    }
    
    NSArray<ToDo*> *dbArray = [[[DaoToDos alloc] init] todosFrom:test];
    

    XCTAssertEqual(todoArray.count,dbArray.count);
    
    for (int i = 0; i < todoArray.count; i++) {
        ToDo* todo = todoArray[i];
        ToDo* dbTodo = dbArray[i];
        XCTAssertEqualObjects(todo.todoTitle, dbTodo.todoTitle);
        XCTAssertEqualObjects(todo.todoContents, dbTodo.todoContents);
        
        XCTAssertEqualObjects([DateTrimmer utcDateString:todo.limitDate], [DateTrimmer utcDateString:dbTodo.limitDate]);
    }
}


/**
 追加したタスクをdelete_flgを建てた場合、通常のタスク一覧画面用の取得メソッドでは取得されないことを確認。
 このテストを実行した後は、ダミータスクとフラグの立ったタスクがDBに追加されている
 */
-(void)testDeleteTask{
    //タスクを追加してdelete_flgを立てて、selectで出てこないことを確認
    
    //念のため、ダミータスクも追加
    ToDo* dammyToDo = [[ToDo alloc] init];
    dammyToDo.todoTitle = @"ダミータスク";
    dammyToDo.todoContents = @"卵、牛乳";
    dammyToDo.limitDate = [NSDate dateWithTimeIntervalSinceNow:5*24*60*60];
    [daoToDos add:dammyToDo to:test];
    
    //タスクをDBに追加
    ToDo* toDo = [[ToDo alloc] init];
    toDo.todoTitle = @"削除したいタスク";
    toDo.todoContents = @"今日はこの課題を終わらせたい";
    toDo.limitDate = [NSDate dateWithTimeIntervalSinceNow:3*24*60*60];
    ToDo* toDoWithID = [daoToDos add:toDo to:test];
    NSInteger todoID = toDoWithID.todoID;
    
    //追加したモデルのフラグを更新
    [daoToDos deleteToDoOf:todoID in:test];
    
    //通常のタスク取得メソッドで取り出してきて、idで一致するものがないことを確認
    NSArray<ToDo*> *dbArray = [[[DaoToDos alloc] init] todosFrom:test];
    for (ToDo* todo in dbArray) {
        XCTAssertNotEqual(todoID, todo.todoID);
    }
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
