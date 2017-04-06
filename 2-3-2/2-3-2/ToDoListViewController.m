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
#pragma mark Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.daoToDos = [[DaoToDos alloc] init];
    NSArray<ToDo*>* existToDos = [self.daoToDos todos];
    
    for (ToDo* todo in existToDos) {
        [self.todos addObject:todo];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark view transition
- (IBAction)addButtonTapped:(UIBarButtonItem *)sender {
    UIStoryboard* sb = [UIStoryboard storyboardWithName:[ToDoDetailViewController className]
                                                 bundle:nil];
    ToDoDetailViewController* vc = [sb instantiateViewControllerWithIdentifier:[ToDoDetailViewController className]];
    vc.modalTransitionStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:true completion:nil];
}
@end
