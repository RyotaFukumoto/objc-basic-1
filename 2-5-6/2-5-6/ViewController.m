//
//  ViewController.m
//  2-5-6
//
//  Created by yogasawara@stv on 2017/04/20.
//  Copyright © 2017年 smart tech ventures. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property CLLocationManager *locationManager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    if (CLLocationManager.locationServicesEnabled) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        [self.locationManager startUpdatingLocation];
    }else{
        [self.locationManager requestAlwaysAuthorization];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark CLLocationManager Delegate

/**
 承認状態が変化するごとに呼ばれる

 @param status 新しい承認ステータス
 */
-(void)locationManager:(CLLocationManager *)manager
didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:{
            [manager requestWhenInUseAuthorization];
            break;
        }
            
        case kCLAuthorizationStatusRestricted:{
            break;
        }
            
        case kCLAuthorizationStatusDenied:{
            break;
        }
            
        case kCLAuthorizationStatusAuthorizedAlways:{
            break;
        }
            
        case kCLAuthorizationStatusAuthorizedWhenInUse:{
            break;
        }
            
        default:
            break;
    }
}

-(void)locationManager:(CLLocationManager *)manager
    didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *newLocation = locations.lastObject;
    NSLog(@"latitude:%.4f,longitude:%.4f",newLocation.coordinate.latitude,newLocation.coordinate.longitude);
}

@end
