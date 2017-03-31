//
//  PageViewController.m
//  2-1-16
//
//  Created by yuu ogasawara on 2017/03/29.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "PageViewController.h"
#import "ViewController.h"

@interface PageViewController ()

@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setViewControllers:@[[self generatePageFromPageNumber:kFirstPageNumber]]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:true
                  completion:nil];
    self.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Page generate
-(ViewController*)generatePageFromPageNumber:(NSInteger)pageNumber{
    ViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:kViewControllerIdentifier];
    vc.pageNumber = pageNumber;
    return vc;
}

#pragma mark UIPageViewController DataSource
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController
     viewControllerBeforeViewController:(UIViewController *)viewController{
    ViewController* vc = (ViewController*)viewController;
    NSInteger pageNumber = vc.pageNumber;
    
    if (pageNumber == kFirstPageNumber) {
        return nil;
    }else{
        return [self generatePageFromPageNumber:pageNumber-1];
    }
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    ViewController* vc = (ViewController*)viewController;
    NSInteger pageNumber = vc.pageNumber;
    if (pageNumber == kLastPageNumber) {
        return nil;
    }else{
        return [self generatePageFromPageNumber:pageNumber + 1];
    }
}
@end
