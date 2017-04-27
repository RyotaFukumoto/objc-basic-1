//
//  DetailViewController.m
//  2-6-2
//
//  Created by yuu ogasawara on 2017/04/27.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "DetailViewController.h"

//plistの読み込み時に、配列か辞書か選択するための列挙型
typedef enum : NSInteger{
    Array = 0,
    Dictionary
}RootType;

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize titleLabel,keyLabel,valueLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)showAction:(NSDictionary *)query
{
    if (query[@"title"] && query[@"key"]) {
        [self configureView:query];
        return YES;
    }
    
    return NO;
}

-(void)configureView:(NSDictionary*)query{
    
    self.titleLabel.text = query[@"title"];
    self.keyLabel.text = query[@"key"];
    
    //plistから値を読み込んできて設定
    NSArray *array = [self objectFromPlistOf:@"Films"
                             rootTypeOfPlist:Array];
    for (NSDictionary* dic in array) {
        if (dic[@"title"]==query[@"title"]) {
            self.valueLabel.text = dic[query[@"key"]];
        }
    }
}

/**
 plistからオブジェクトを取得する
 
 @param fileName plistの名前
 @param type plistのrootの型。
 @return plistから取得したオブジェクト。
 */
- (id)objectFromPlistOf:(NSString *)fileName
        rootTypeOfPlist:(RootType)type
{
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:fileName ofType:@"plist"];
    
    switch (type) {
        case Array:
            return [NSArray arrayWithContentsOfFile:path];
            break;
            
        case Dictionary:
            return [NSDictionary dictionaryWithContentsOfFile:path];
            break;
    }
}
@end
