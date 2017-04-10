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
             DLog(@"%@",self.forecastsArray.description.decodeJSONString);
         }
     
         failure:^(NSURLSessionTask *operation, NSError *error) {
             // エラーの場合の処理
             NSLog(@"error");
         }
     ];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
