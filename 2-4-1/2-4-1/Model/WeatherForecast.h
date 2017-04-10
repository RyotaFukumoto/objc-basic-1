//
//  WeatherForecast.h
//  2-4-1
//
//  Created by yogasawara@stv on 2017/04/10.
//  Copyright © 2017年 stv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherImage.h"

@interface WeatherForecast : NSObject
@property NSDate* date;
@property WeatherImage* image;
@property NSString* telop;
@property NSInteger maxTemprature;
@property NSInteger minTemprature;
@end
