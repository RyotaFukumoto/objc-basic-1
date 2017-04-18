//
//  ViewController.m
//  2-5-3
//
//  Created by yuu ogasawara on 2017/04/18.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "CameraViewController.h"

@interface CameraViewController ()

//UI
@property (weak, nonatomic) IBOutlet UIImageView *videoPreviewView;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;

//AV Foundation
@property (nonatomic) AVCaptureSession  *captureSesssion;
@property AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (nonatomic) AVCapturePhotoOutput *stillImageOutput;

@end

@implementation CameraViewController

/**
 ビデオカメラからの映像をimageViewに表示する設定を行う。
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.captureSesssion = [[AVCaptureSession alloc] init];
    self.captureSesssion.sessionPreset = AVCaptureSessionPreset1920x1080;
    self.stillImageOutput = [[AVCapturePhotoOutput alloc] init];
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = [[NSError alloc] init];
    
    /**
     Swiftでは、AVCaptureDeviceInputの初期化はthrowsになっており、do catch節に入っているので、こちらも合わせた
     */
    @try{
        AVCaptureDeviceInput* input = [[AVCaptureDeviceInput alloc] initWithDevice:device
                                                                             error:&error];
        if ([self.captureSesssion canAddInput:input]) {
            [self.captureSesssion addInput:input];
            if ([self.captureSesssion canAddOutput:self.stillImageOutput]) {
                [self.captureSesssion addOutput:self.stillImageOutput];
                [self.captureSesssion startRunning];
                AVCaptureVideoPreviewLayer* captureVideoLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSesssion];
                captureVideoLayer.frame = self.videoPreviewView.bounds;
                captureVideoLayer.videoGravity = AVLayerVideoGravityResizeAspect;
                [self.videoPreviewView.layer addSublayer:captureVideoLayer];
            }
        }
    }
    @catch (NSException *ex){
        NSLog(@"%@",error);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)takePhoto:(UIButton *)sender {
    AVCapturePhotoSettings* settings = [[AVCapturePhotoSettings alloc] init];
    settings.flashMode = AVCaptureFlashModeAuto;
    [self.stillImageOutput capturePhotoWithSettings:settings
                                           delegate:self];
}

#pragma mark AVCapturePhotoCaptureDelegate
-(void)captureOutput:(AVCapturePhotoOutput *)captureOutput
didFinishProcessingPhotoSampleBuffer:(nullable CMSampleBufferRef)photoSampleBuffer
previewPhotoSampleBuffer:(nullable CMSampleBufferRef)previewPhotoSampleBuffer
    resolvedSettings:(nonnull AVCaptureResolvedPhotoSettings *)resolvedSettings
     bracketSettings:(nullable AVCaptureBracketedStillImageSettings *)bracketSettings
               error:(nullable NSError *)error
{
    NSData* photoData = [AVCapturePhotoOutput JPEGPhotoDataRepresentationForJPEGSampleBuffer:photoSampleBuffer
                                                                    previewPhotoSampleBuffer:previewPhotoSampleBuffer];
    
    UIImage* resutImage = [[UIImage alloc] initWithData:photoData];
    self.photoView.image = resutImage;
    UIImageWriteToSavedPhotosAlbum(resutImage, nil, nil, nil);
}
@end
