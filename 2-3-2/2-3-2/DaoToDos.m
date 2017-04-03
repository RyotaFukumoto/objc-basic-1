//
//  DaoToDos.m
//  2-3-2
//
//  Created by yuu ogasawara on 2017/04/03.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "DaoToDos.h"

NSString* const kDBFileName = @"app.db";
NSString* const kSQLCreate = @"CREATE TABLE IF NOT EXISTS tr_todo (todo_id INTEGER PRIMARY KEY AUTOINCREMENT,todo_title TEXT NOT NULL,todo_contents TEXT,created DATETIME,modified DATETIME,limit_date DATETIME,delete_flg BOOL);";

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
    
    //TODO:ファイル名参照のためログに出しているので、消す
    NSLog(@"%@",dir);
    
    return [dir stringByAppendingPathComponent:kDBFileName];
}

@end
