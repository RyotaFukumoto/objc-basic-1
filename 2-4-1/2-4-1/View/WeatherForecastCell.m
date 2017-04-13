//
//  WeatherForecastCell.m
//  2-4-1
//
//  Created by yogasawara@stv on 2017/04/10.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "WeatherForecastCell.h"
#import "NSString+DateFormat.h"

@implementation WeatherForecastCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellFor:(WeatherForecast *)weatherForecast{
    self.dateLabel.text = [NSString dateString:weatherForecast.date];
    self.weatherLabel.text = weatherForecast.telop;
    
}

#pragma mark utility
+ (NSString*)className {
    return NSStringFromClass([WeatherForecastCell class]);
}
@end
