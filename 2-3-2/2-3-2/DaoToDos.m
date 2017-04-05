//
//  DaoToDos.m
//  2-3-2
//
//  Created by yuu ogasawara on 2017/04/03.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "DaoToDos.h"
#import "DateTrimmer.h"

//TODO: 今はテスト用のテーブルtr_todo_testを作成しているので、適切なタイミングでtr_todoに切り替えること！
NSString* const kDBFileName = @"app.db";
NSString* const kSQLCreate = @"CREATE TABLE IF NOT EXISTS tr_todo_test(todo_id INTEGER PRIMARY KEY AUTOINCREMENT,todo_title TEXT NOT NULL,todo_contents TEXT,created DATETIME default current_timestamp,modified DATETIME default current_timestamp,limit_date DATETIME,delete_flg BOOL default 0);";

NSString* const kSQLInsert = @"insert into tr_todo_test(todo_title,todo_contents,limit_date) values(?, ?, ?);";

@interface DaoToDos()
@property (nonatomic, copy) NSString* dbPath; //! データベース　ファイルへのパス

- (FMDatabase*)fetchFMDB;
+ (NSString*)composeDbFilePath;
@end

@implementation DaoToDos
#pragma mark - Lifecycle methods

/**
 * インスタンスを初期化します。
 *
 * @return 初期化後のインスタンス。
 */
- (id)init
{
    self = [super init];
    if( self )
    {
        FMDatabase* db = [self fetchFMDB];
        [db open];
        [db executeUpdate:kSQLCreate];
        [db close];
    }
    
    return self;
}

#pragma mark - Public methods
/**
 * タスクを追加します。
 *
 * @param todo 書籍。
 *
 * @return 成功時は識別子を割り当てられたタスク、失敗時は nilが返る。
 */
- (nullable ToDo*)add:(ToDo *)todo
{
    FMDatabase* db = [self fetchFMDB];
    [db open];
    
    [db setShouldCacheStatements:YES];
    
    //limit_dateをdataformatterでUTCに変換してから保存する
    NSString* utcLimitDateString = [DateTrimmer utcDateString:todo.limit_date];
    if( [db executeUpdate:kSQLInsert, todo.todo_title, todo.todo_contents, utcLimitDateString] )
    {
        todo.todo_id = [db lastInsertRowId];
    }
    else
    {
        todo = nil;
    }
    
    [db close];
    
    return todo;
}

#pragma mark - Private methods

/**
 * データベースを取得します。
 *
 * @return データベース。
 */
- (FMDatabase *)fetchFMDB
{
    if( self.dbPath == nil )
    {
        self.dbPath =  [DaoToDos composeDbFilePath];
    }
    
    return [FMDatabase databaseWithPath:self.dbPath];
}

/**
 * データベース ファイルのパスを取得します。
 */
+ (NSString*)composeDbFilePath
{
    NSArray*  paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    
    NSString* dir   = [paths objectAtIndex:0];
    
    DLog(@"%@",dir);
    
    return [dir stringByAppendingPathComponent:kDBFileName];
}

@end
