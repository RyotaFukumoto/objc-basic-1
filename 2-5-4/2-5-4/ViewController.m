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
    
    //画像のアスペクト比を変えず、Viewをはみ出さずめいいっぱいに表示する
    self.cameraRollImageView.contentMode = UIViewContentModeScaleAspectFit;
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

#pragma mark UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    if (info[UIImagePickerControllerOriginalImage]) {
        self.cameraRollImageView.image = (UIImage*)info[UIImagePickerControllerOriginalImage];
    }
    
    [picker dismissViewControllerAnimated:YES
                               completion:nil];
}
@end
