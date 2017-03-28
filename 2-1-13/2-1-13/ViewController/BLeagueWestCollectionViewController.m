//
//  BLeagueWestCollectionViewController.m
//  2-1-13
//
//  Created by yogasawara@stv on 2017/03/27.
//  Copyright © 2017年 smart tech ventures. All rights reserved.
//

#import "BLeagueWestCollectionViewController.h"
#import "BLeagueCollectionViewHeader.h"

@interface BLeagueWestCollectionViewController (){
    UICollectionViewFlowLayout *vFlowLayout;
    NSArray<NSString*> *teams;
    
    //[tohokuKey:[（Team型の東北のチーム）],hokurikuKey:[(Team*)北陸のチーム]
    NSDictionary *teamsDict;
}
@end

typedef NS_ENUM (NSUInteger, sectionName) {
    tohoku,
    hokuriku
};

@implementation BLeagueWestCollectionViewController
static NSString * const reuseIdentifier = @"Cell";
static NSString * const reuseHeaderIdentifier = @"Header";

#pragma mark Life Cycles
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        vFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        vFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        vFlowLayout.headerReferenceSize = CGSizeMake(0.0f, 30.0f);
        vFlowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat collectionViewWidth = self.collectionView.bounds.size.width;
    vFlowLayout.itemSize = CGSizeMake(collectionViewWidth* 3/7, collectionViewWidth* 3/7);
    
    // Register cell classes
    [self.collectionView registerClass:[BLeagueCollectionViewCell class]
            forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerClass:[BLeagueCollectionViewHeader class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:reuseHeaderIdentifier];
    
    [self.collectionView setCollectionViewLayout:vFlowLayout];
    
    //load team data
    teamsDict = [[TeamManager alloc] init].teams;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [teamsDict count];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    switch (section) {
        case tohoku:
            return [teamsDict[tohokuKey] count];
            break;
        case hokuriku:
            return [teamsDict[hokurikuKey] count];
        default:
            break;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BLeagueCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                                                forIndexPath:indexPath];
    
    // Configure the cell
    NSArray *teamArray = [NSArray alloc];
    Team* team = [Team alloc];
    switch (indexPath.section) {
        case tohoku:
            teamArray = teamsDict[tohokuKey];
            team = teamArray[indexPath.row];
            break;
        case hokuriku:
            teamArray = teamsDict[hokurikuKey];
            team = teamArray[indexPath.row];
        default:
            break;
    }
    
    cell.logoImageView.image = team.image;
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
          viewForSupplementaryElementOfKind:(NSString *)kind
                                atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *resusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        BLeagueCollectionViewHeader *header = [self.collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                                   withReuseIdentifier:reuseHeaderIdentifier
                                                                                          forIndexPath:indexPath];
        switch (indexPath.section) {
            case tohoku:
            {
                header.label.text = tohokuKey;
                break;
            }
            case hokuriku:
            {
                header.label.text = hokurikuKey;
                break;
            }
            default:
                header.label.text = @"unknown";
                break;
        }
        resusableView = header;
    }
    return resusableView;
}

@end
