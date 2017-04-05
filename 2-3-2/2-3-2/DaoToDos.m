//
//  DaoToDos.m
//  2-3-2
//
//  Created by yuu ogasawara on 2017/04/03.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "DaoToDos.h"

NSString* const kDBFileName = @"app.db";

NSString* const kColumnName_ToDo_ID = @"todo_id";
NSString* const kColumnName_ToDo_Title = @"todo_title";
NSString* const kColumnName_ToDo_Contents = @"todo_contents";
NSString* const kColumnName_Created = @"created";
NSString* const kColumnName_Modified = @"modified";
NSString* const kColumnName_Limit_Date = @"limit_date";
NSString* const kColumnName_delete_flg = @"delete_flg";

//TODO: 状況フラグはマクロに移行
//どのテーブルにレコードを記録するかこの定数で決定している
//YES: developテーブル
//NO: releaseテーブル
BOOL const kDebugMode = YES;

@interface DaoToDos()
@property (nonatomic, copy) NSString* dbPath; //データベース　ファイルへのパス

- (FMDatabase*)fetchFMDB;
+ (NSString*)composeDbFilePath;
@end

@implementation DaoToDos
#pragma mark - Life cycle methods
/**
 * 初期化の過程で、無ければテーブルを作成します。
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
        
        //開発段階では、developテーブルを作成する
        if (kDebugMode) {
            [db executeUpdate:[self createTableSQLQueryOf:develop]];
        }else{
            [db executeUpdate:[self createTableSQLQueryOf:release]];
        }
        
        [db close];
    }
    
    return self;
}

-(id)initForTest{
    self = [super init];
    if( self )
    {
        FMDatabase* db = [self fetchFMDB];
        [db open];
        [db executeUpdate:[self createTableSQLQueryOf:test]];
        [self deleteAllRecordIn:test];
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
    //開発段階では、developテーブルに加える
    if (kDebugMode) {
        return [self add:todo to:develop];
    }else{
        return [self add:todo to:release];
    }
}

- (nullable ToDo*)add:(ToDo *)todo
                   to:(TableName)tableName
{
    FMDatabase* db = [self fetchFMDB];
    [db open];
    [db setShouldCacheStatements:YES];
    
    NSString* tableNameText = GetTableNameText(tableName);
    NSMutableString* insertQueryMutableString = [NSMutableString string];
    [insertQueryMutableString appendString:[NSString stringWithFormat:@"insert into %@",tableNameText]];
    [insertQueryMutableString appendString:@"(todo_title,todo_contents,limit_date) "];
    [insertQueryMutableString appendString:@"values(?, ?, ?);"];
    NSString* insertQuery = insertQueryMutableString.copy;
    
    //limit_dateをdataformatterでUTCのタイムゾーンでNSStringに変換してからDBに保存する
    //※NSStringに変換せずにNSDateのままでinsertを実行すると、DBには数値で保存される
    NSString* utcLimitDateString = [DateTrimmer utcDateString:todo.limit_date];
    if( [db executeUpdate:insertQuery, todo.todo_title, todo.todo_contents, utcLimitDateString] )
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

-(NSArray*)todos
{
    //開発段階では、developテーブルからレコードを取り出す
    if (kDebugMode) {
        return [self todosFrom:develop];
    }else{
        return [self todosFrom:release];
    }
}


/**
 削除フラグが立っていないtodoを、DBから期限が近い順に取得して返す

 @param tableName 開発中ならtr_todo_testテーブルから
 @return 削除フラグが立っていないレコード由来のタスクの配列。期限が近い順に配列に格納している
 */
-(NSArray<ToDo*>*)todosFrom:(TableName)tableName
{
    FMDatabase* db = [self fetchFMDB];
    [db open];
    
    NSString* tableNameText = GetTableNameText(tableName);
    NSMutableString* selectQueryMutableString = [NSMutableString string];
    [selectQueryMutableString appendString:@"select * from "];
    [selectQueryMutableString appendString:[NSString stringWithFormat:@"%@ ",tableNameText]];
    [selectQueryMutableString appendString:@"where delete_flg = 0 "];
    [selectQueryMutableString appendString:@"order by limit_date asc;"];

    NSString* selectQuery = selectQueryMutableString.copy;
    FMResultSet* results = [db executeQuery:selectQuery];
    
    NSMutableArray* todos = [NSMutableArray array];
    while ([results next]) {
        ToDo* todo = [[ToDo alloc] init];
        todo.todo_id = [results intForColumn:kColumnName_ToDo_ID];
        todo.todo_title = [results stringForColumn:kColumnName_ToDo_Title];
        todo.todo_contents = [results stringForColumn:kColumnName_ToDo_Contents];
        
        //todo.created = [results dateForColumn:kColumnName_Created];
        todo.created = [DateTrimmer dateFrom:[results stringForColumn:kColumnName_Created]];
        
        //todo.modified = [results dateForColumn:kColumnName_Modified];
        todo.modified = [DateTrimmer dateFrom:[results stringForColumn:kColumnName_Modified]];
        //todo.limit_date = [results dateForColumn:kColumnName_Limit_Date];
        todo.limit_date = [DateTrimmer dateFrom:[results stringForColumn:kColumnName_Limit_Date]];
        
        [todos addObject:todo];
    }
    
    [db close];
    return todos;
}


/**
 テスト用に追加した。取扱注意。

 @param tableName すべてのレコードを削除したいテーブル.testを想定。
 */
-(void)deleteAllRecordIn:(TableName)tableName
{
    NSString* tableNameText = GetTableNameText(tableName);
    NSString* sql = [NSString stringWithFormat:@"DELETE FROM %@",tableNameText];
    FMDatabase* db = [self fetchFMDB];
    [db open];
    [db executeUpdate:sql];
    [db close];
}

#pragma mark - Private methods

/**
 引数に基づいたテーブルを作成するSQL文を返す。FMDBのexecuteUpdate:メソッドに与える引数を返すことを意識して実装した

 @param tableName テーブルを指定
 @return スキーマの要件を満たすcreate文
 */
-(NSString*)createTableSQLQueryOf:(TableName)tableName
{
    NSString* tableNameText = GetTableNameText(tableName);
    
    NSMutableString* createTableQuery = [NSMutableString string];
    [createTableQuery appendString:@"CREATE TABLE IF NOT EXISTS "];
    [createTableQuery appendString:[NSString stringWithFormat:@"%@(", tableNameText]];
    [createTableQuery appendString:@"todo_id INTEGER PRIMARY KEY AUTOINCREMENT,"];
    [createTableQuery appendString:@"todo_title TEXT NOT NULL,"];
    [createTableQuery appendString:@"todo_contents TEXT,"];
    [createTableQuery appendString:@"created DATETIME default current_timestamp,"];
    [createTableQuery appendString:@"modified DATETIME default current_timestamp,"];
    [createTableQuery appendString:@"limit_date DATETIME,"];
    [createTableQuery appendString:@"delete_flg BOOL default 0);"];

    return createTableQuery.copy;
}

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
 * データベース ファイルのパスを取得して、ログにも出力します
 */
+ (NSString*)composeDbFilePath
{
    NSArray*  paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    
    NSString* dir   = [paths objectAtIndex:0];
    
    DLog(@"%@",dir);
    
    return [dir stringByAppendingPathComponent:kDBFileName];
}

@end
