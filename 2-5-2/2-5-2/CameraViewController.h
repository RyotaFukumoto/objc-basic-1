//
//  ViewController.h
//  2-5-2
//
//  Created by yuu ogasawara on 2017/04/18.
//  Copyright © 2017年 stv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property UIPopoverController *popover;

@end

