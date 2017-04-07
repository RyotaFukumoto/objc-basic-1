//
//  DaoToDos.h
//  2-3-2
//
//  Created by yuu ogasawara on 2017/04/03.
//  Copyright © 2017年 stv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
#import "ToDo.h"
#import "DateTrimmer.h"

//テーブルを足す場合は、このTableName型と、TableNameTextListを追加のこと
//参考：http://qiita.com/ShinChan/items/e4839aefe4d9d89198a8
//NS_ENUMにマクロを追加して、値に対応する文字列を取得できるようにした
typedef NS_ENUM(NSUInteger, TableName){
    release,
    test,
    develop
};
#define TableNameTextList @[@"tr_todo",@"tr_todo_test",@"tr_todo_develop"]      //テーブル名のリテラル
//TableName型から文字列
#define GetTableNameText(type) TableNameTextList[type]
//文字列からTableName型
#define GetTableName(typeText) (TableName)[TableNameTextList indexOfObject:typeText]

//開発中はYESにしてtr_todo_developテーブルを使用する
extern BOOL const kDebugMode;

@interface DaoToDos : NSObject

/**
 テスト用のテーブルを作成し、レコードがあれば削除する

 @return DBを扱うオブジェクト
 */
-(id _Nullable)initForTest;

//セッタ
- (nullable ToDo*)add:(ToDo *_Nonnull)todo;
- (nullable ToDo*)add:(ToDo *_Nonnull)todo
                   to:(TableName)tableName;

-(void)insertDammyTasks;

//ゲッタ
-(nullable NSArray<ToDo*>*)todos;
-(NSArray<ToDo*>* _Nullable)todosFrom:(TableName)tableName;

//削除
-(void)removeAllRecordIn:(TableName)tableName;
-(void)deleteToDoOf:(NSInteger)id;
-(void)deleteToDoOf:(NSInteger)id in:(TableName)tableName;

@end
