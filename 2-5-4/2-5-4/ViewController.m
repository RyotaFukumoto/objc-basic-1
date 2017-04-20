//
//  ViewController.m
//  2-5-4
//
//  Created by yogasawara@stv on 2017/04/20.
//  Copyright © 2017年 smart tech ventures. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *cameraRollImageView;

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

#pragma mark Show Camera Roll
- (IBAction)buttonTapped:(UIButton *)sender {
    [self pickImageFromLibrary];
}

- (void)pickImageFromLibrary{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController* pickerController = [[UIImagePickerController alloc] init];
        pickerController.delegate = self;
        
        pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:pickerController
                           animated:YES
                         completion:nil];
    }
}
@end
