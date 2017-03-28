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
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    CGFloat collectionViewWidth = self.collectionView.bounds.size.width;
    vFlowLayout.itemSize = CGSizeMake(collectionViewWidth/3, collectionViewWidth/3);
    
    // Register cell classes
    [self.collectionView registerClass:[BLeagueCollectionViewCell class]
            forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerClass:[BLeagueCollectionViewHeader class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:reuseHeaderIdentifier];
    
    [self.collectionView setCollectionViewLayout:vFlowLayout];
    
    //status barに被らないようにする
    CGFloat topMargin = self.topLayoutGuide.length;
    CGFloat bottomMargin = self.bottomLayoutGuide.length;
    [self.collectionView setContentInset:UIEdgeInsetsMake(topMargin,0,bottomMargin,0)];
    
    //load team data
    teamsDict = [[TeamManager alloc] init].teams;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
        //NSArray<Team*> *teamArray = [NSArray alloc];
        switch (indexPath.section) {
            case tohoku:
            {
//                teamArray = teamsDict[tohokuKey];
//                Team *team = (Team *)teamArray[indexPath.row];
//                header.label.text = team.name;
                header.label.text = tohokuKey;
                break;
            }
            case hokuriku:
            {
//                teamArray = teamsDict[hokurikuKey];
//                Team *team = (Team *)teamArray[indexPath.row];
//                header.label.text = team.name;
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

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
