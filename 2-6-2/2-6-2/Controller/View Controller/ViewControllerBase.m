//
//  ViewControllerBase.m
//  2-6-2
//
//  Created by yuu ogasawara on 2017/04/27.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "ViewControllerBase.h"

@interface ViewControllerBase ()

@end

@implementation ViewControllerBase

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (BOOL)action:(NSString *)action
         query:(NSDictionary *)query{
    SEL sel = NSSelectorFromString([NSString stringWithFormat:@"%@Action:", action]);
    if ([self respondsToSelector:sel]) {
        BOOL (*actionImp)(id, SEL, NSDictionary *);
        actionImp = (BOOL (*)(id, SEL, NSDictionary *))[self methodForSelector:sel];
        return actionImp(self, sel, query);
    }
    return NO;
}
@end
