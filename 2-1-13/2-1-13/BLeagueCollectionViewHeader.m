//
//  BLeagueCollectionViewHeader.m
//  2-1-13
//
//  Created by yogasawara@stv on 2017/03/28.
//  Copyright © 2017年 smart tech ventures. All rights reserved.
//

#import "BLeagueCollectionViewHeader.h"

@implementation BLeagueCollectionViewHeader
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)];
        self.label.backgroundColor = [UIColor clearColor];
        self.label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:self.label];
    }
    return self;
}
@end
