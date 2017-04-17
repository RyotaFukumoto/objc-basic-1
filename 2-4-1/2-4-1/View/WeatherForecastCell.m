//
//  WeatherForecastCell.m
//  2-4-1
//
//  Created by yogasawara@stv on 2017/04/10.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "WeatherForecastCell.h"
#import "NSString+DateFormat.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"

@implementation WeatherForecastCell
#pragma mark life Cycle
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


/**
 セルのキャッシュを使いまわさないように、セルの再表示前に最初期化する
 */
-(void)prepareForReuse{
    self.dateLabel.text = @"";
    self.weatherLabel.text = @"";
    self.weatherImageView.image = [UIImage imageNamed:@"no_image"];
}

#pragma mark Configure View
- (void)setSelected:(BOOL)selected
           animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellFor:(WeatherForecast *)weatherForecast{
    self.dateLabel.text = [NSString dateString:weatherForecast.date];
    self.weatherLabel.text = weatherForecast.telop;
    
    //urlからキャッシュを参照して、キャッシュがない場合だけダウンロードしてくる
    //cf. https://gist.github.com/sahara-ooga/f8698c4cc8344d9c2bef54483c1320d2
    NSString *urlString = weatherForecast.weatherImage.imageURL;
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest* request = [NSURLRequest requestWithURL:url
                                             cachePolicy:NSURLRequestReloadRevalidatingCacheData
                                         timeoutInterval:120];
    
    //NSURLRequest* request = [NSURLRequest requestWithURL:url];
    UIImage *placeholderImage = [UIImage imageNamed:@"no_image"];
    
    [self.weatherImageView setImageWithURLRequest:request
                                 placeholderImage:placeholderImage
                                          success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                              //FIXME: selfの扱いはweakで修正
                                              self.weatherImageView.image = image;
                                              [self setNeedsLayout];
                                          }
                                          failure:nil];
}

-(void)configureCellFor:(WeatherRecord*)weatherRecord{
    self.dateLabel.text = weatherRecord[kColumnNameForecastDate];
    self.weatherLabel.text = weatherRecord[kColumnNameForecastWeather];
    
    //urlからキャッシュを参照して、キャッシュがない場合だけダウンロードしてくる
    //cf. https://gist.github.com/sahara-ooga/f8698c4cc8344d9c2bef54483c1320d2
    NSString *urlString = weatherRecord[kColumnNameImageURL];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest* request = [NSURLRequest requestWithURL:url
                                             cachePolicy:NSURLRequestReloadRevalidatingCacheData
                                         timeoutInterval:120];
    
    //NSURLRequest* request = [NSURLRequest requestWithURL:url];
    UIImage *placeholderImage = [UIImage imageNamed:@"no_image"];
    
    [self.weatherImageView setImageWithURLRequest:request
                                 placeholderImage:placeholderImage
                                          success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
                                              //FIXME: selfの扱いはweakで修正
                                              self.weatherImageView.image = image;
                                              [self setNeedsLayout];
                                          }
                                          failure:nil];
}

#pragma mark utility
+ (NSString*)className {
    return NSStringFromClass([WeatherForecastCell class]);
}
@end
