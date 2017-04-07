//
//  ToDoListViewController.m
//  2-3-2
//
//  Created by yuu ogasawara on 2017/04/04.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "ToDoListViewController.h"
#import "ToDoDetailViewController.h"
#import "ToDoListViewController+ToDoListViewDelegate.h"

@interface ToDoListViewController ()

@end

@implementation ToDoListViewController
#pragma mark Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.daoToDos = [DaoToDos shared];
    
    //開発中はダミータスクを入れる
    if (kDebugMode){
        [self.daoToDos insertDammyTasks];
    }
    
    NSArray<ToDo*>* existToDos = [self.daoToDos todos];
    
    self.todos = [NSMutableArray arrayWithArray:existToDos];
    
    [self.tableView registerNib:[UINib nibWithNibName:[ToDoListCell className]
                                               bundle:nil]
         forCellReuseIdentifier:[ToDoListCell className]];
    
    
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
    vc.delegate = self;
    [self presentViewController:vc animated:true completion:nil];
}
@end
