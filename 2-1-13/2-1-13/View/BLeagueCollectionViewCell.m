//
//  BLeagueCollectionViewCell.m
//  2-1-13
//
//  Created by yogasawara@stv on 2017/03/27.
//  Copyright © 2017年 smart tech ventures. All rights reserved.
//

#import "BLeagueCollectionViewCell.h"

@implementation BLeagueCollectionViewCell
-(void)prepareForReuse{
    [super prepareForReuse];
    self.logoImageView.image = nil;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.logoImageView = [[UIImageView alloc] init];
        self.logoImageView.frame = self.bounds;
        [self.contentView addSubview:self.logoImageView];
        self.contentMode = UIViewContentModeScaleAspectFill;
    }
    
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    return self;
}
@end
