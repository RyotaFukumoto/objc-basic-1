//
//  BiographyViewController.m
//  2-6-2
//
//  Created by yuu ogasawara on 2017/04/28.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "BiographyViewController.h"

//plistの読み込み時に、配列か辞書か選択するための列挙型
typedef enum : NSInteger{
    Array = 0,
    Dictionary
}RootType;

@interface BiographyViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation BiographyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //表示前に改めてUIパーツの設定を行う。
    [self configureView];
    
}

-(BOOL)configureView{
    //plistから値を読み込んできて設定
    NSDictionary<NSString*,NSString*> *dictionary = [self objectFromPlistOf:@"Biography"
                                                          rootTypeOfPlist:Dictionary];
    
    self.textView.text = dictionary[@"biography"];
    return YES;
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
