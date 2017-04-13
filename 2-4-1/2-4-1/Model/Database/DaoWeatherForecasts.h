//
//  DaoWeatherForecasts.h
//  2-4-1
//
//  Created by yogasawara@stv on 2017/04/10.
//  Copyright © 2017年 stv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
#import "WeatherForecast.h"

//テーブルを足す場合は、このTableName型と、TableNameTextListを追加のこと
//参考：http://qiita.com/ShinChan/items/e4839aefe4d9d89198a8
//NS_ENUMにマクロを追加して、値に対応する文字列を取得できるようにした
typedef NS_ENUM(NSUInteger, TableName){
    release,
    test,
    develop
};
#define TableNameTextList @[@"tr_forecast",@"tr_forecast_test",@"tr_forecast_develop"]      //テーブル名のリテラル
//TableName型から文字列
#define GetTableNameText(type) TableNameTextList[type]
//文字列からTableName型
#define GetTableName(typeText) (TableName)[TableNameTextList indexOfObject:typeText]

//開発中はYESにしてtr_forecast_developテーブルを使用する
extern BOOL const kDebugMode;

@interface DaoWeatherForecasts : NSObject
-(id _Nullable)initForTest;
+ (DaoWeatherForecasts*_Nullable)shared;

//セッタ
- (nullable WeatherForecast*)add:(WeatherForecast *_Nonnull)WeatherForecast;
- (nullable WeatherForecast*)add:(WeatherForecast *_Nonnull)WeatherForecast
                   to:(TableName)tableName;

//-(void)insertDammyTasks;

//ゲッタ
//-(nullable NSArray<WeatherForecast*>*)WeatherForecasts;
//-(NSArray<WeatherForecast*>* _Nullable)WeatherForecastsFrom:(TableName)tableName;

//削除
//-(void)removeAllRecordIn:(TableName)tableName;
//-(void)deleteWeatherForecastOf:(NSInteger)id;
//-(void)deleteWeatherForecastOf:(NSInteger)id in:(TableName)tableName;

@end
