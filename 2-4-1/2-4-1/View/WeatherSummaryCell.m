//
//  WeatherSummaryCell.m
//  2-4-1
//
//  Created by yogasawara@stv on 2017/04/10.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "WeatherSummaryCell.h"
@interface WeatherSummaryCell()
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@end
@implementation WeatherSummaryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellFor:(NSString *)weatherSummary{
    self.summaryLabel.text = weatherSummary;
}

#pragma mark utility
+ (NSString*)className {
    return NSStringFromClass([WeatherSummaryCell class]);
}
@end
