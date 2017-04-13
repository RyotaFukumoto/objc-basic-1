//
//  DaoWeatherForecasts.m
//  2-4-1
//
//  Created by yogasawara@stv on 2017/04/10.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "DaoWeatherForecasts.h"
#import "NSDate+DateFormat.h"
#import "WeatherForecastConnector.h"

NSString* const kDBFileName = @"app.db";

NSString* const kColumnNameForecastDate = @"forecast_date";
NSString* const kColumnNameForecastWeather = @"forecast_weather";
NSString* const kColumnNameImageURL = @"image_url";

//どのテーブルにレコードを記録するかこの定数で決定している
//YES: developテーブル
//NO: releaseテーブル
BOOL const kDebugMode = YES;
@interface DaoWeatherForecasts()
@property (nonatomic, copy) NSString* dbPath; //データベース　ファイルへのパス

- (FMDatabase*)fetchFMDB;
+ (NSString*)composeDbFilePath;
@end

@implementation DaoWeatherForecasts
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
    
    //コネクタが天気予報を取得した際の通知の登録
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(connectorDidFinishFetchWeatherForecast:)
                                                 name:kConnectorDidFinishFetchWeatherForecast
                                               object:nil];

    return self;
}

/**
 DBとテスト用のテーブルの実在を確定させて、テスト用のテーブルのレコードがあれば全て削除する
 
 @return <#return value description#>
 */
-(id)initForTest{
    self = [super init];
    if( self )
    {
        FMDatabase* db = [self fetchFMDB];
        [db open];
        [db executeUpdate:[self createTableSQLQueryOf:test]];
        [self removeAllRecordIn:test];
        [db close];
    }
    
    //コネクタが天気予報を取得した際の通知の登録
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(connectorDidFinishFetchWeatherForecast:)
                                                 name:kConnectorDidFinishFetchWeatherForecast
                                               object:nil];

    return self;
}


/**
 通信結果をDBに保存する。保存項目は予報日、天気、アイコンのURL

 @param notification userInfoにパース結果が入っている
 */
-(void)connectorDidFinishFetchWeatherForecast:(NSNotification*)notification{
    //データを受け取る
    
    //DBに保存する
    
    //天気予報APIのレスポンス、JSONをパースしたもの
    NSDictionary* parsedDictionary = notification.userInfo;
    
    //天気予報の概要
    NSString* weatherSummaryString = parsedDictionary[@"description"][@"text"];
    
    //各日の天気予報
    NSArray<NSDictionary*>* forecasts = parsedDictionary[@"forecasts"];
    for (NSDictionary* forecastDict in forecasts) {
        NSDate* date = forecastDict[@"date"];
        
    }

}

+ (DaoWeatherForecasts*)shared{
    static DaoWeatherForecasts* shared;
    if (shared == nil) {
        shared = [[DaoWeatherForecasts alloc] init];
    }
    
    return shared;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Public methods
/**
 * タスクを追加します。
 *
 * @param forecast 書籍。
 *
 * @return 成功時は識別子を割り当てられたタスク、失敗時は nilが返る。
 */
- (nullable WeatherForecast*)add:(WeatherForecast *)forecast
{
    //開発段階では、developテーブルに加える
    if (kDebugMode) {
        return [self add:forecast to:develop];
    }else{
        return [self add:forecast to:release];
    }
}

- (nullable WeatherForecast*)add:(WeatherForecast *)forecast
                   to:(TableName)tableName
{
    FMDatabase* db = [self fetchFMDB];
    [db open];
    [db setShouldCacheStatements:YES];
    
    NSString* tableNameText = GetTableNameText(tableName);
    NSMutableString* insertQueryMutableString = [NSMutableString string];
    [insertQueryMutableString appendString:[NSString stringWithFormat:@"insert into %@",tableNameText]];
    [insertQueryMutableString appendString:[NSString stringWithFormat:@"(%@,%@,%@) ",kColumnNameForecastDate,kColumnNameForecastWeather,kColumnNameImageURL]];
    [insertQueryMutableString appendString:@"values(?, ?, ?);"];
    NSString* insertQuery = insertQueryMutableString.copy;
    
    //NSDateオブジェクトはUTCのタイムゾーンでNSStringに変換してからDBに保存する
    //※NSStringに変換せずにNSDateのままでinsertを実行すると、DBには数値で保存される
    if( [db executeUpdate:insertQuery, forecast.date.utcDateString, forecast.telop, forecast.weatherImage.imageURL] )
    {
        NSLog(@"save successfully forecast in %@",forecast.date);
    }
    else
    {
        NSLog(@"Error has happened when saving forecast in %@",forecast.date);
    }
    
    [db close];
    
    return forecast;
}

/**
 テスト用に追加した。取扱注意。
 
 @param tableName すべてのレコードを削除したいテーブル.testを想定。
 */
-(void)removeAllRecordIn:(TableName)tableName
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
        self.dbPath =  [DaoWeatherForecasts composeDbFilePath];
    }
    
    return [FMDatabase databaseWithPath:self.dbPath];
}

/**
 * データベース ファイルのパスを取得して、ログにも出力します
 */
+ (NSString*)composeDbFilePath
{
    NSArray<NSString*>*  paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    
    NSString* dir   = [paths objectAtIndex:0];
    
    DLog(@"DB Path = %@",dir);
    
    return [dir stringByAppendingPathComponent:kDBFileName];
}

@end
