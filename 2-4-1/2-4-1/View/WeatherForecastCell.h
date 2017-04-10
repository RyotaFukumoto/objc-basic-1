//
//  WeatherForecastCell.h
//  2-4-1
//
//  Created by yogasawara@stv on 2017/04/10.
//  Copyright © 2017年 stv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherForecastCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *weatherLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImageView;

@end
