//
//  TATableViewCell.h
//  2-1-14
//
//  Created by yogasawara@stv on 2017/03/25.
//  Copyright © 2017年 stv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TATableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *explainLabel;
@property (weak, nonatomic) IBOutlet UIImageView *portraitView;

@end
