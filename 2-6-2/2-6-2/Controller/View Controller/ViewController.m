//
//  ViewController.m
//  2-6-2
//
//  Created by yuu ogasawara on 2017/04/27.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "DetailController.h"
#import "BiographyController.h"
#import "BiographyViewController.h"

@interface ViewController ()

@end

@implementation ViewController
#pragma mark Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ControllerBaseDelegate
-(BOOL)setView:(ControllerBase *)controllerBase
           For:(NSDictionary *)query{
    
    if ([controllerBase isMemberOfClass:[DetailController class]]) {
        return [self pushToDetail:query];
    }
    
    if ([controllerBase isMemberOfClass:[BiographyController class]]) {
        return [self pushToBiography:query];
    }
    
    return NO;
}

-(BOOL)pushToDetail:(NSDictionary*)query{
    DetailViewController *detailViewController = [[DetailViewController alloc] init];
    detailViewController.query = query;
    BOOL b = [detailViewController configureView:query];
    
    [self.navigationController pushViewController:detailViewController
                                         animated:YES];
    
    return b;
}

-(BOOL)pushToBiography:(NSDictionary*)query{
    BiographyViewController *biographyViewController = [[BiographyViewController alloc] init];
    
    [self.navigationController pushViewController:biographyViewController
                                         animated:YES];
    
    return YES;
}

#pragma mark Test URL Scheme
- (IBAction)fullMetalJacketButtonTapped:(UIButton *)sender {
    
    NSURL *url = [NSURL URLWithString:@"kubrick://detail/show?title=Full+Metal+Jacket&key=year"];
    UIApplication *application = [UIApplication sharedApplication];
    if ([application canOpenURL:url]) {
        NSDictionary *options = @{UIApplicationOpenURLOptionUniversalLinksOnly : @NO};
        [application openURL:url
                     options:options
           completionHandler:nil];
    }
}

- (IBAction)biographyButtonTapped:(UIButton *)sender {
    
    NSURL *url = [NSURL URLWithString:@"kubrick://biography/show"];
    UIApplication *application = [UIApplication sharedApplication];
    if ([application canOpenURL:url]) {
        NSDictionary *options = @{UIApplicationOpenURLOptionUniversalLinksOnly : @NO};
        [application openURL:url
                options:options
      completionHandler:nil];
    }
}

@end
