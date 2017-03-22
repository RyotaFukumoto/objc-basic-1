//
//  ViewController.m
//  1−1−4
//
//  Created by yuu ogasawara on 2017/03/17.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray<NSString*> *nameArray = @[@"John",@"Paul",@"George",@"Ringo",@"Yoko"];
    NSArray<NSNumber*> *ageArray = @[@26,@24,@23,@26,@33];
    NSArray<NSString*> *sexArray = @[@"男性",@"男性",@"男性",@"男性",@"女性"];
    NSArray<NSString*> *favoriteLanguageArray = @[@"英語",@"英語",@"英語",@"英語",@"日本語"];
    
    NSDictionary<NSString*, NSArray*> *beatlesDic = @{@"name":nameArray,
                                 @"age":ageArray,
                                 @"sex":sexArray,
                                 @"favoriteLanguage":favoriteLanguageArray};
    
    NSMutableArray *beatlesplus = [NSMutableArray arrayWithCapacity:5];
    
    for (int i = 0; i < [nameArray count]; i++) {
        Account *member = [[Account alloc] initWithName:beatlesDic[@"name"][i]
                                                    age:[beatlesDic[@"age"][i] integerValue]    //NSNumber型からNSInteger型の値を取り出す
                                                    sex:beatlesDic[@"sex"][i]
                                       favoriteLanguage:beatlesDic[@"favoriteLanguage"][i]];
        [beatlesplus addObject:member];
    }

    for (Account *member in beatlesplus) {
        [member showInfo];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
