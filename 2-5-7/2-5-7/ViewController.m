//
//  ViewController.m
//  2-5-7
//
//  Created by yogasawara@stv on 2017/04/20.
//  Copyright © 2017年 smart tech ventures. All rights reserved.
// 参考：http://qiita.com/woxtu/items/8594cb37830571a47d4a

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self pinAtKamata];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark map
//マーカーを日本工学院蒲田校に立てる
-(void)pinAtKamata{
    CLLocationCoordinate2D kamataCoordinate = CLLocationCoordinate2DMake(35.564942,139.715643);
    MKPointAnnotation* pin = [[MKPointAnnotation alloc] init];
    pin.coordinate = kamataCoordinate;
    pin.title = @"日本工学院専門学校蒲田校";
    [self.mapView addAnnotation:pin];
}
@end
