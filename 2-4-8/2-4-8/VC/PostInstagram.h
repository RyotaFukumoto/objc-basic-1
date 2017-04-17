//
//  PostInstagram.h
//  2-4-8
//
//  Created by yuu ogasawara on 2017/04/17.
//  Copyright © 2017年 stv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostInstagram : UIViewController<UIDocumentInteractionControllerDelegate>
{
    UIDocumentInteractionController *interactionCotroller;
}

+ (BOOL)canInstagramAppOpen;
- (void)setImage:(UIImage *)image;

@property (nonatomic,retain) UIDocumentInteractionController *interactionController;

@end
