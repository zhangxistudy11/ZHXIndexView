//
//  ViewController.m
//  ZHXIndexView
//
//  Created by 张玺 on 2020/4/4.
//  Copyright © 2020 张玺. All rights reserved.
//

#define ScreenWidth     [UIScreen mainScreen].bounds.size.width
#define ScreenHeight     [UIScreen mainScreen].bounds.size.height


#import "ViewController.h"
#import "UIColor+Extension.h"
#import "ZHXCityItemCollectionCell.h"
#import "ZHXCityCollectionHeader.h"

static  NSString *const kCollectionCellIdentifier = @"ZHXIndexViewCellIdentifier";
static  NSString *const kCollectionHeaderIdentifier = @"ZHXIndexViewHeaderIdentifier";


@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property(nonatomic,strong) UILabel *titleLB;
@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) NSArray *cityList;
@property(nonatomic,strong) NSArray *indexData;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"ZHXIndexView";
    self.view.backgroundColor = [UIColor colorWithString:@"#f5f5f5"];

    [self setUpView];
    [self laodCityData];
}

- (void)setUpView {
    [self.view addSubview:self.titleLB];
    [self.view addSubview:self.collectionView];
}
- (void)laodCityData {
    self.indexData = @[@"A",@"B",@"C",@"D",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"R",@"S",@"T",@"U",@"D",@"V",@"W",@"X",@"D",@"Y",@"Z"];
    NSArray *suppositionalGroup = @[@"angeLes",@"newYork",@"london",@"beijing",@"shanghai",@"osaka",@"barcelona"];
    NSMutableArray *cityMulList = [[NSMutableArray alloc]init];
    for (NSString *letter in self.indexData) {
        NSInteger count = (arc4random() % 13) + 7;
        NSMutableArray *cityData = [[NSMutableArray alloc]init];
          for (int i=0; i<count; i++) {
              NSInteger suppositionalIndex = (arc4random() % 6) + 0;
              NSString *suppositionalCity = [NSString stringWithFormat:@"%@%@",letter,[suppositionalGroup objectAtIndex:suppositionalIndex]];
              [cityData addObject:suppositionalCity];
          }
        NSDictionary *cityDataGroup = @{letter:cityData};
        [cityMulList addObject:cityDataGroup];
    }
    self.cityList = [cityMulList copy];
    [self.collectionView reloadData];
}
#pragma mark - UICollectionViewDelegate & UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.cityList.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSDictionary *cityDict = [self.cityList objectAtIndex:section];
    NSArray *cityGroup = [cityDict valueForKey:[self.indexData objectAtIndex:section]];
    return cityGroup.count;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
return UIEdgeInsetsMake(10, 15, 12, 24);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 8;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 8;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    float itemCellWidth = (ScreenWidth-15-24-3*8)/4;
    return CGSizeMake(itemCellWidth, 34);
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZHXCityItemCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionCellIdentifier forIndexPath:indexPath];
    NSDictionary *cityDict = [self.cityList objectAtIndex:indexPath.section];
    NSArray *cityGroup = [cityDict valueForKey:[self.indexData objectAtIndex:indexPath.section]];
    [cell updateCityName:[cityGroup objectAtIndex:indexPath.row]];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(ScreenWidth, 30);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        ZHXCityCollectionHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kCollectionHeaderIdentifier forIndexPath:indexPath];
        NSString *title = self.indexData[indexPath.section];
        [header updateCityIndex:title];
        return header;
    }
    return nil;
}
#pragma mark - Getter Method
- (UILabel *)titleLB {
    if (!_titleLB) {
        _titleLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, ScreenWidth, 50)];
        _titleLB.textColor = [UIColor blackColor];
        _titleLB.font = [UIFont boldSystemFontOfSize:20];
        _titleLB.textAlignment = NSTextAlignmentCenter;
        _titleLB.text = @"ZHXIndexView";
    }
    return _titleLB;
}
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,100, ScreenWidth, ScreenHeight-100) collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.scrollsToTop = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[ZHXCityCollectionHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kCollectionHeaderIdentifier];

        [_collectionView registerClass:[ZHXCityItemCollectionCell class] forCellWithReuseIdentifier:kCollectionCellIdentifier];
        _collectionView.backgroundColor = [UIColor clearColor];
    }
    return _collectionView;
}


@end
