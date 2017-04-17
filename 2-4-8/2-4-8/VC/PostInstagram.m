//
//  PostInstagram.m
//  2-4-8
//
//  Created by yuu ogasawara on 2017/04/17.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "PostInstagram.h"

@interface PostInstagram ()
- (void)closeView;
@end

@implementation PostInstagram

+ (BOOL)canInstagramAppOpen{
    NSURL *instagramURL = [NSURL URLWithString:@"instagram://app"];
    if ([[UIApplication sharedApplication] canOpenURL:instagramURL]) {
        return YES;
    }
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)openInstagram {
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/image.igo"];
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    
    self.interactionController = [UIDocumentInteractionController interactionControllerWithURL:fileURL];
    self.interactionController.UTI = @"com.instagram.exclusivegram";
    self.interactionController.delegate = self;
    
    BOOL present = [self.interactionController presentOpenInMenuFromRect:self.view.frame
                                                                  inView:self.view
                                                                animated:YES];
    if (!present) {
        [self closeView];
    }
}

- (void)setImage:(UIImage *)image
{
    NSData *imageData = UIImageJPEGRepresentation(image, 0.75f);
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/image.igo"];
    [imageData writeToFile:filePath atomically:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self openInstagram];
}
- (void)closeView
{
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
    self.interactionController.delegate = nil;
}

#pragma mark - UIDocumentInteractionControllerDelegate

- (void)documentInteractionController:(UIDocumentInteractionController *)controller
        willBeginSendingToApplication:(NSString *)application
{
    
}

- (void)documentInteractionController:(UIDocumentInteractionController *)controller
           didEndSendingToApplication:(NSString *)application
{
    [self closeView];
}

- (void) documentInteractionControllerDidDismissOpenInMenu: (UIDocumentInteractionController *) controller
{
    // キャンセルで閉じたとき
    [self closeView];
}

@end
