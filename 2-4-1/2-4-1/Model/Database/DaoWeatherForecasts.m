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
#import "Const.h"

NSString* const kDBFileName = @"app.db";

NSString* const kColumnNameForecastDate = @"forecast_date";
NSString* const kColumnNameForecastWeather = @"forecast_weather";
NSString* const kColumnNameImageURL = @"image_url";

//どのテーブルにレコードを記録するかこの定数で決定している
//YES: developテーブル
//NO: releaseテーブル
BOOL const kDebugMode = YES;

///キーは上で定義した列名を使用
typedef NSDictionary<NSString*,NSString*> WeatherRecord;

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
 テスト用の初期化メソッド。DBとテスト用のテーブルの実在を確定させて、テスト用のテーブルのレコードがあれば全て削除する
 
 @return テスト用のテーブルを生成したDao.
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
 * モデルクラスをDBに追加します。Managerクラスからの利用を想定
 *
 * @param forecast WeatherForecaset型。予報日・天気・アイコンのURLを文字列で保持
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
 * 天気情報のレコードを追加します。本番用
 *
 * @param forecastDict 予報日・天気・アイコンのURLを文字列で保持するNSDictionaryのtypedef
 *
 * @return 成功時は保存に成功したforecastDict、失敗時は nilが返る。
 */
- (nullable WeatherRecord*)addRecord:(WeatherRecord *)forecastDict
{
    //開発段階では、developテーブルに加える
    if (kDebugMode) {
        return [self addRecord:forecastDict to:develop];
    }else{
        return [self addRecord:forecastDict to:release];
    }
}

/**
 このメソッドがpublicになっているのは、テストクラスから呼びたいから

 @param forecastDict テーブルの列名と同じキーでアクセスできます
 @param tableName 本番：release,開発：develop、テスト：test
 @return 保存できた場合だけ保存に成功したオブジェクトを返します
 */
- (nullable WeatherRecord *)addRecord:(WeatherRecord *)forecastDict
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
    if( [db executeUpdate:insertQuery, forecastDict[kColumnNameForecastDate], forecastDict[kColumnNameForecastWeather], forecastDict[kColumnNameImageURL]])
    {
        NSLog(@"save successfully forecast in %@",forecastDict[kColumnNameForecastDate]);
        [db close];
        return forecastDict;
    }
    else
    {
        NSLog(@"Error has happened when saving forecast in %@",forecastDict[kColumnNameForecastDate]);
        [db close];
        return nil;
    }
    
}

-(NSArray<WeatherRecord*>* _Nullable)WeatherForecasts{
    //開発段階では、developテーブルからレコードを取り出す
    if (kDebugMode) {
        return [self weatherForecastsFrom:develop];
    }else{
        return [self weatherForecastsFrom:release];
    }
}

/**
 特に条件なくすべてのレコードを取り出してくる

 @param tableName ableName 本番：release,開発：develop、テスト：test
 @return 取り出してきたレコードをWeatherRecoroオブジェクトに詰めたもの、の配列
 */
-(NSArray<WeatherRecord*>* _Nullable)weatherForecastsFrom:(TableName)tableName{
    FMDatabase* db = [self fetchFMDB];
    [db open];
    
    //SQLクエリの組み立て
    NSString* tableNameText = GetTableNameText(tableName);
    NSMutableString* selectQueryMutableString = [NSMutableString string];
    [selectQueryMutableString appendString:@"select * from "];
    [selectQueryMutableString appendString:[NSString stringWithFormat:@"%@ ",tableNameText]];
    NSString* selectQuery = selectQueryMutableString.copy;
    
    //DBから取り出した結果を、モデルオブジェクトに詰める
    FMResultSet* results = [db executeQuery:selectQuery];
    NSMutableArray<WeatherRecord*>* records = [NSMutableArray array];
    
    while ([results next]) {
        
        
        NSString* date = [results stringForColumn:kColumnNameForecastDate];
        NSString* weather = [results stringForColumn:kColumnNameForecastWeather];
        NSString* imageURLString = [results stringForColumn:kColumnNameImageURL];
        
        WeatherRecord* weatherRecord = @{kColumnNameForecastDate:date,
                                         kColumnNameForecastWeather:weather,
                                         kColumnNameImageURL:imageURLString};
        
        [records addObject:weatherRecord];
    }
    
    [db close];
    
    NSArray *forecastsArray = [records copy];
    return forecastsArray;
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
 コネクタがデータを取得できたタイミングで、通信結果をDBに保存する。保存項目は予報日、天気、アイコンのURL。セーブできたレコードをuserInfoにつけてNSNotificationを投げる
 
 @param notification userInfoにパース結果が入っている
 */
-(void)connectorDidFinishFetchWeatherForecast:(NSNotification*)notification{
    //天気予報APIのレスポンス、JSONをパースしたもの
    NSDictionary* parsedDictionary = notification.userInfo;
    NSMutableArray* mWeatherRecordArray = [NSMutableArray array];
    
    //各日の天気予報
    NSArray<NSDictionary*>* forecasts = parsedDictionary[@"forecasts"];
    for (NSDictionary* forecastDict in forecasts) {
        NSString* dateString = forecastDict[@"date"];
        NSString* weatherString = forecastDict[@"telop"];
        NSString* imageURLString = forecastDict[@"image"][@"url"];
        WeatherRecord* record = @{kColumnNameForecastDate:dateString,
                                  kColumnNameForecastWeather:weatherString,
                                  kColumnNameImageURL:imageURLString};
        
        DaoWeatherForecasts* dao = [DaoWeatherForecasts shared];
        WeatherRecord* savedRecord = [dao addRecord:record];
        [mWeatherRecordArray addObject:savedRecord];
    }
    
    NSArray* savedRecords = [mWeatherRecordArray copy];
    NSDictionary<NSString*,NSArray*>* dictionary = @{@"savedRecords":savedRecords};
    
    //NOTE: 当初の実装ではNSNotificationを使った以下の実装だったものの、テストクラスでの受信ができなかったため、デリゲートに変更した。
    //セーブできたレコードをつけて投げる
    /*[[NSNotificationCenter defaultCenter] postNotificationName:kDaoDidFinishSaveParsedData
                                                        object:self
                                                      userInfo:dictionary];
    
    */
    
    if ([self.delegate respondsToSelector:@selector(daoDidSaveRecord:userInfo:)]) {
        [self.delegate daoDidSaveRecord:self userInfo:dictionary];
    }
}

/**
 引数に基づいたテーブルを作成するSQL文を返す。FMDBのexecuteUpdate:メソッドに与える引数を返すことを意識して実装した
 例：@"CREATE TABLE IF NOT EXISTS tr_forecast_test(forecast_date, forecast_weather, image_url);
 @param tableName テーブルを指定
 @return スキーマの要件を満たすcreate文
 */
-(NSString*)createTableSQLQueryOf:(TableName)tableName
{
    NSString* tableNameText = GetTableNameText(tableName);
    
    NSMutableString* createTableQuery = [NSMutableString string];
    [createTableQuery appendString:@"CREATE TABLE IF NOT EXISTS "];
    [createTableQuery appendString:[NSString stringWithFormat:@"%@(", tableNameText]];
    [createTableQuery appendString:[NSString stringWithFormat:@"%@, ",kColumnNameForecastDate]];
    [createTableQuery appendString:[NSString stringWithFormat:@"%@, ",kColumnNameForecastWeather]];
    [createTableQuery appendString:[NSString stringWithFormat:@"%@);",kColumnNameImageURL]];
        
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
    
    NSLog(@"DB Path = %@",dir);
    
    return [dir stringByAppendingPathComponent:kDBFileName];
}

@end
