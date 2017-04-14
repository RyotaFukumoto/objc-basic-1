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

///キー名は別に定義したテーブルの列名を使用
typedef NSDictionary<NSString*,NSString*> WeatherRecord;

//テーブル名のリテラル
#define TableNameTextList @[@"tr_forecast",@"tr_forecast_test",@"tr_forecast_develop"]
//TableName型から文字列
#define GetTableNameText(type) TableNameTextList[type]
//文字列からTableName型
#define GetTableName(typeText) (TableName)[TableNameTextList indexOfObject:typeText]

//開発中はYESにしてtr_forecast_developテーブルを使用する
extern BOOL const kDebugMode;

extern NSString* _Nonnull const kColumnNameForecastDate;
extern NSString* _Nonnull const kColumnNameForecastWeather;
extern NSString* _Nonnull const kColumnNameImageURL;

@class DaoWeatherForecasts;
@protocol DaoDelegate <NSObject>

@optional
- (void)daoDidSaveRecord:(DaoWeatherForecasts*_Nonnull)dao
                userInfo:(NSDictionary*_Nullable)userInfo;

@end

@interface DaoWeatherForecasts : NSObject
@property (nonatomic,weak,nullable) id<DaoDelegate> delegate;

-(id _Nullable)initForTest;
+ (DaoWeatherForecasts*_Nullable)shared;

//セッタ
- (nullable WeatherForecast*)add:(WeatherForecast *_Nonnull)WeatherForecast;
- (nullable WeatherForecast*)add:(WeatherForecast *_Nonnull)WeatherForecast
                   to:(TableName)tableName;
- (nullable WeatherRecord *)addRecord:(WeatherRecord *_Nonnull)forecastDict;
- (nullable WeatherRecord *)addRecord:(WeatherRecord *_Nonnull)forecastDict
                                   to:(TableName)tableName;
//-(void)insertDammyForecasts;

//ゲッタ
-(NSArray<WeatherRecord*>* _Nullable)WeatherForecasts;
-(NSArray<WeatherRecord*>* _Nullable)weatherForecastsFrom:(TableName)tableName;

//削除
-(void)removeAllRecordIn:(TableName)tableName;

@end
