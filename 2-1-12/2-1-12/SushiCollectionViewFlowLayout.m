//
//  SushiCollectionViewFlowLayout.m
//  2-1-12
//
//  Created by yuu ogasawara on 2017/03/24.
//  Copyright © 2017年 stv. All rights reserved.
//

#import "SushiCollectionViewFlowLayout.h"

@implementation SushiCollectionViewFlowLayout
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    [attributes enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *attribute, NSUInteger idx, BOOL *stop) {
        CGRect rect = attribute.bounds;
        rect.size.width += 10;
        attribute.bounds = rect;
    }];
    return attributes;
}

@end
