//
//  SushiCollectionViewCell.m
//  PlayUICollectionView
//
//  Created by yogasawara@stv on 2017/03/27.
//  Copyright © 2017年 smart tech ventures. All rights reserved.
//

#import "SushiCollectionViewCell.h"

@implementation SushiCollectionViewCell
-(void)prepareForReuse{
    [super prepareForReuse];
    _sushiImageView.image = nil;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.sushiImageView = [[UIImageView alloc] init];
        self.sushiImageView.frame = self.bounds;
        [self.contentView addSubview:self.sushiImageView];
        self.contentMode = UIViewContentModeScaleAspectFill;
    }
    
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    return self;
}
@end
