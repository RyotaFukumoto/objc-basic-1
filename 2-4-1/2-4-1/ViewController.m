//
//  ViewController.m
//  2-4-1
//
//  Created by yuu ogasawara on 2017/04/07.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "NSString+decodeJSONString.h"

NSString* const kWeatherReportAPIURLForTokyo = @"http://weather.livedoor.com/forecast/webservice/json/v1?city=130010";

@interface ViewController ()
@property NSArray<NSDictionary*>* forecastsArray;
@end

@implementation ViewController
#pragma mark Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *url = kWeatherReportAPIURLForTokyo;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:url parameters:nil progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             // json取得に成功した場合の処理
             //responseObjectはNSDictionary型
             NSDictionary *dict = (NSDictionary*)responseObject;
             
             //今日明日明後日の情報を配列に格納する
             self.forecastsArray = dict[@"forecasts"];
         }
     
         failure:^(NSURLSessionTask *operation, NSError *error) {
             // エラーの場合の処理
             DLog(@"error");
         }
     ];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ログに表示
/**
 action sheetで今日、明日、明後日を選ぶようにする
 参考：http://nlogic.jp/?p=261
 @param sender Infoボタン
 */
- (IBAction)infoButtonTapped:(UIButton *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"日を選んでください"
                                                                             message:@"天気予報"
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    //今日、明日ボタンを設置。ボタンを押したらその日の天気をログに表示
    NSArray* array = @[@"今日",@"明日"];
    [array enumerateObjectsUsingBlock:^(NSString* obj, NSUInteger index, BOOL *stop){
        UIAlertAction *action = [UIAlertAction actionWithTitle:obj
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action) {
                                                           DLog(@"clicked Button title: %@", action.title);
                                                           //レスポンスはユニコードエスケープされているので、一旦エスケープを処理してからログに出す
                                                           DLog(@"%@の天気予報:%@",action.title,self.forecastsArray[index].description.decodeJSONString);
                                                       }];
        [alertController addAction:action];
    }];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Cancel"
                                                     style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction *action) {
                                                       DLog(@"clicked Button title: %@", action.title);
                                                   }];
    [alertController addAction:action];
    
    [self presentViewController:alertController
                       animated:YES
                     completion:nil];
}
@end
