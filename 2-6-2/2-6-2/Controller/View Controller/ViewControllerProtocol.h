//
//  ViewControllerProtocol.h
//  2-6-2
//
//  Created by yuu ogasawara on 2017/04/27.
//  Copyright © 2017年 stv. All rights reserved.
//

#ifndef ViewControllerProtocol_h
#define ViewControllerProtocol_h
@import UIKit;
@protocol ViewControllerProtocol <NSObject>

@property UILabel* titleLabel;
@property UILabel* keyLabel;
@property UILabel* valueLabel;

-(void)configureView:(NSDictionary*)query;
@end

#endif /* ViewControllerProtocol_h */
