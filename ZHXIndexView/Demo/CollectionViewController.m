//
//  CollectionViewController.m
//  ZHXIndexView
//
//  Created by 张玺 on 2020/4/4.
//  Copyright © 2020 张玺. All rights reserved.
//

#define ScreenWidth     [UIScreen mainScreen].bounds.size.width
#define ScreenHeight     [UIScreen mainScreen].bounds.size.height


#import "CollectionViewController.h"
#import "UIColor+Extension.h"
#import "ZHXCityItemCollectionCell.h"
#import "ZHXCityCollectionHeader.h"

#import "ZHXIndexView.h"

static  NSString *const kCollectionCellIdentifier = @"ZHXIndexViewCellIdentifier";
static  NSString *const kCollectionHeaderIdentifier = @"ZHXIndexViewHeaderIdentifier";


@interface CollectionViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,ZHXIndexViewDelegate,UIScrollViewDelegate>
@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,assign) float sectionHeaderHeight;
@property(nonatomic,assign) float cellTopMargin;
@property(nonatomic,strong) NSArray *cityList;
@property(nonatomic,strong) NSArray *indexData;
@property(nonatomic,strong) ZHXIndexView *indexView;
@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"CityList";
    self.view.backgroundColor = [UIColor colorWithString:@"#f5f5f5"];
    self.sectionHeaderHeight = 30;
    self.cellTopMargin = 10;
    
    [self setUpView];
    [self laodCityData];
    [self addIndexView];
}

- (void)setUpView {
    [self.view addSubview:self.collectionView];
    
    
}
- (void)laodCityData {
    self.indexData = @[@"Hot",@"Rec",@"His",@"A",@"B",@"C",@"D",@"F",@"O",@"P",@"R",@"S",@"T",@"U",@"D",@"V",@"W",@"X",@"D",@"Y",@"Z",@"#"];
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
- (void)addIndexView {
    self.indexView = [[ZHXIndexView alloc]initIndexViewWithFrame:CGRectMake(ScreenWidth-24, 180, 24, 550)];
    [self.view addSubview:self.indexView];
    self.indexView.delegate = self;
    self.indexView.itemTitleColor = [UIColor colorWithString:@"#999999"];
    self.indexView.itemHighlightColor = [UIColor colorWithString:@"#198CFF"];
    self.indexView.itemTitleFont = [UIFont systemFontOfSize:10];
    self.indexView.indexTitles = self.indexData;
    self.indexView.itemNoHighlightIndexArray = @[@(0),@(1),@(2),@(self.indexData.count-1)];

}
#pragma mark - ZHXIndexViewDelegate
- (void)indexViewDidSelectIndex:(NSInteger)index {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:index];
    CGFloat offsetY = [self.collectionView layoutAttributesForItemAtIndexPath:indexPath].frame.origin.y;
    /**
     If you set section header , collectionView edgeInsets .
     Please exclude it .
     */
    if (self.sectionHeaderHeight>0) {
        offsetY = offsetY - self.sectionHeaderHeight;
    }
    if (self.cellTopMargin>0) {
        offsetY = offsetY - self.cellTopMargin;
    }
    [self.collectionView setContentOffset:CGPointMake(0, offsetY) animated:NO];
}
#pragma mark - UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.indexView updateItemHighlightWhenScrollStopWithDispalyView:self.collectionView];
    });
}
#pragma mark - Getter Method

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
    return UIEdgeInsetsMake(self.cellTopMargin, 15, 12, 24);
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
    return CGSizeMake(ScreenWidth, self.sectionHeaderHeight);
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

@end
