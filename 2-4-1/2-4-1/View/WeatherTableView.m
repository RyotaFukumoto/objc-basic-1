//
//  WeatherTableView.m
//  2-4-1
//
//  Created by yogasawara@stv on 2017/04/16.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "WeatherTableView.h"
#import "WeatherSummaryCell.h"
#import "WeatherForecastCell.h"
#import "WeatherForecastDataSource.h"

@interface WeatherTableView ()
@property (nonatomic) WeatherForecastDataSource *wDataSource;

@end

@implementation WeatherTableView

/**
 テーブルビューの初期設定をする
 */
- (void)configureView{
    
    //TableViewの表示のための設定
    [self registerNib:[UINib nibWithNibName:[WeatherSummaryCell className]
                                               bundle:nil]
         forCellReuseIdentifier:[WeatherSummaryCell className]];
    
    [self registerNib:[UINib nibWithNibName:[WeatherForecastCell className]
                                               bundle:nil]
         forCellReuseIdentifier:[WeatherForecastCell className]];
    
    //NOTE:WeatherForecastDatasourceオブジェクトをdatasourceに直接代入すると、datasourceオブジェクトが開放されてしまう。
    self.wDataSource = [[WeatherForecastDataSource alloc] init];
    self.dataSource = self.wDataSource;
    
    ///セルの高さを可変にする
    ///参考：http://tomoyaonishi.hatenablog.jp/entry/2014/09/27/161152
    self.estimatedRowHeight = 150.0;
    self.rowHeight = UITableViewAutomaticDimension;
}
@end
