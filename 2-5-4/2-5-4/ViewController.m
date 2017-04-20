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

/**
 画像をカメラロールで選択した際に呼ばれるデリゲートメソッド.
 画像をモノクロに変更してImageViewに表示する

 @param picker <#picker description#>
 @param info <#info description#>
 */
-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage* pickedImage = (UIImage*)info[UIImagePickerControllerOriginalImage];
    
    if (pickedImage) {
        UIImage* filteredImage = [self applyFilterFor:pickedImage
                                           filterName:@"CIPhotoEffectMono"];
        
        self.cameraRollImageView.image = filteredImage;
    }
    
    [picker dismissViewControllerAnimated:YES
                               completion:nil];
}

#pragma mark Filter
-(UIImage*)applyFilterFor:(UIImage*)image
               filterName:(NSString*)filterName{
    
    //参考：http://qiita.com/jok/items/7c9e384abb29c161f56b
    CIImage* ciImage = [[CIImage alloc] initWithImage:image];
    CIFilter *ciFilter = [CIFilter filterWithName:filterName];
    [ciFilter setValue:ciImage forKey:kCIInputImageKey];
    CIContext* ciContext = [CIContext context];
    CIImage *outputImage = ciFilter.outputImage;
    
    if (outputImage) {
        CGImageRef cgImgRef = [ciContext createCGImage:outputImage
                                            fromRect:outputImage.extent];
        
        UIImage* filteredImage = [UIImage alloc];
        
        //cgImgRefは横長になっているため、元画像が縦長なら、補正する
        if (image.size.height > image.size.width) {
            filteredImage = [UIImage imageWithCGImage:cgImgRef
                                                     scale:1.0
                                               orientation:UIImageOrientationRight];
        }else{
            filteredImage = [UIImage imageWithCGImage:cgImgRef];
        }
        
        return filteredImage;
    }
    
    return nil;
}
@end
