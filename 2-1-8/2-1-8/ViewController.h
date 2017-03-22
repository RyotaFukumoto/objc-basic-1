//
//  ViewController.h
//  2-1-8
//
//  Created by yuu ogasawara on 2017/03/22.
//  Copyright © 2017年 stv. All rights reserved.
//

#import <UIKit/UIKit.h>

extern const float AREA_PICKER_ACCESSORY_HEIGHT;
extern const float AREA_PICKER_HEIGHT;

@interface ViewController : UIViewController{
    
}
@property(nonatomic, strong) UIView *areaView;


@end

@interface ViewController (TouchEvent)

@end

@interface ViewController (AddView)
- (void)buildAreaPickerView;
@end
