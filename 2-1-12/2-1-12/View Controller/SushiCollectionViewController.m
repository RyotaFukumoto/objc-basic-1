//
//  SushiCollectionViewController.m
//  PlayUICollectionView
//
//  Created by yogasawara@stv on 2017/03/27.
//  Copyright © 2017年 smart tech ventures. All rights reserved.
//

#import "SushiCollectionViewController.h"

@interface SushiCollectionViewController (){
    UICollectionViewFlowLayout *vFlowLayout;
    NSArray<NSString*> *sushis;
}

@end

@implementation SushiCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        vFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        vFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat collectionViewWidth = self.collectionView.bounds.size.width;
    vFlowLayout.itemSize = CGSizeMake(collectionViewWidth, collectionViewWidth);
    
    // Register cell classes
    [self.collectionView registerClass:[SushiCollectionViewCell class]
            forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView setCollectionViewLayout:vFlowLayout];
    
    sushis = @[@"アカガイ",@"アジ",@"アナゴ",@"イカ",@"イクラ",@"イワシ",@"ウニ",@"カジキマグロ",@"カツオ"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return sushis.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SushiCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                                           forIndexPath:indexPath];
    if (cell == nil) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    }
    
    UIImage *sushiImage = [UIImage imageNamed:sushis[indexPath.row]];
    cell.sushiImageView.image = sushiImage;
    
    return cell;
}

@end
