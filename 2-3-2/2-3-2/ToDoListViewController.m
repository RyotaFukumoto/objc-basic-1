//
//  ToDoListViewController.m
//  2-3-2
//
//  Created by yuu ogasawara on 2017/04/04.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "ToDoListViewController.h"
#import "ToDoDetailViewController.h"

@interface ToDoListViewController ()

@end

@implementation ToDoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark view transition
- (IBAction)addButtonTapped:(UIBarButtonItem *)sender {
    UIStoryboard* sb = [UIStoryboard storyboardWithName:@"ToDoDetailViewController" bundle:nil];
    ToDoDetailViewController* vc = [sb instantiateViewControllerWithIdentifier:@"ToDoDetailViewController"];
    vc.modalTransitionStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:true completion:nil];
}

@end
