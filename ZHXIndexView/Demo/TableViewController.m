//
//  TableViewController.m
//  ZHXIndexView
//
//  Created by 张玺 on 2020/4/6.
//  Copyright © 2020 张玺. All rights reserved.
//
#define ScreenWidth     [UIScreen mainScreen].bounds.size.width
#define ScreenHeight     [UIScreen mainScreen].bounds.size.height
#import "TableViewController.h"
#import "UIColor+Extension.h"
#import "ZHXCityItemCollectionCell.h"
#import "ZHXCityCollectionHeader.h"

#import "ZHXIndexView.h"

@interface TableViewController ()<UITableViewDataSource,UITableViewDelegate,ZHXIndexViewDelegate,UIScrollViewDelegate>
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,assign) float sectionHeaderHeight;
@property(nonatomic,strong) NSArray *nameList;
@property(nonatomic,strong) NSArray *indexData;
@property(nonatomic,strong) ZHXIndexView *indexView;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sectionHeaderHeight = 30;

    
    self.navigationItem.title = @"Address Book";
    self.view.backgroundColor = [UIColor colorWithString:@"#f5f5f5"];
    [self setUpView];
    [self laodCityData];
    [self addIndexView];
}
- (void)setUpView {
    _tableView = [[UITableView  alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame)
                                                               , CGRectGetHeight(self.view.frame)) style:UITableViewStylePlain];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view  addSubview:_tableView];
    
}
- (void)laodCityData {
    self.indexData = @[@"A",@"B",@"C",@"D",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"R",@"S",@"T",@"U",@"D",@"V",@"W",@"X",@"D",@"Y",@"Z"];
    NSArray *suppositionalGroup = @[@"JAMES",@"LISA",@"THOMAS",@"ROBERT",@"JOHN",@"PAUL",@"SUSAN"];
    NSMutableArray *cityMulList = [[NSMutableArray alloc]init];
    for (NSString *letter in self.indexData) {
        NSInteger count = (arc4random() % 5) + 2;
        NSMutableArray *cityData = [[NSMutableArray alloc]init];
        for (int i=0; i<count; i++) {
            NSInteger suppositionalIndex = (arc4random() % 6) + 0;
            NSString *suppositionalCity = [NSString stringWithFormat:@"%@%@",letter,[suppositionalGroup objectAtIndex:suppositionalIndex]];
            [cityData addObject:suppositionalCity];
        }
        NSDictionary *cityDataGroup = @{letter:cityData};
        [cityMulList addObject:cityDataGroup];
    }
    self.nameList = [cityMulList copy];
    [self.tableView reloadData];
}
- (void)addIndexView {
    self.indexView = [[ZHXIndexView alloc]initWithFrame:CGRectMake(ScreenWidth-24, 180, 24, 550)];
    [self.view addSubview:self.indexView];
    self.indexView.delegate = self;
    
    self.indexView.indexTitles = self.indexData;
    self.indexView.itemTitleColor = [UIColor colorWithString:@"#999999"];
    self.indexView.itemSelectedBackgroundColor = [UIColor colorWithString:@"#198CFF"];
}
#pragma mark - ZHXIndexViewDelegate
- (void)indexViewDidSelectIndex:(NSInteger)index {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:index];
//    CGFloat offsetY = [self.tableView rectForRowAtIndexPath:indexPath].origin.y;
////    [self.tableView layoutatt]
//    /**
//     If you set section header , collectionView edgeInsets .
//     Please exclude it .
//     */
////    if (self.sectionHeaderHeight>0) {
////        offsetY = offsetY - self.sectionHeaderHeight;
////    }
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
}
#pragma mark - UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *indexPathsForVisibleRows= self.tableView.indexPathsForVisibleRows;
        NSIndexPath *minIndexPath = [NSIndexPath indexPathForRow:0 inSection:9999];
        NSIndexPath *maxIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        
        for (int i=0; i<indexPathsForVisibleRows.count; i++) {
            NSIndexPath *itemIndex = [indexPathsForVisibleRows objectAtIndex:i];
            minIndexPath = [itemIndex compare:minIndexPath]==NSOrderedDescending?minIndexPath:itemIndex;
            maxIndexPath = [itemIndex compare:maxIndexPath]==NSOrderedDescending?itemIndex:maxIndexPath;
        }
        [self.indexView changeSelectIndexWhenScrollStop:minIndexPath.section];
    });
}
#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.nameList.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *cityDict = [self.nameList objectAtIndex:section];
    NSArray *cityGroup = [cityDict valueForKey:[self.indexData objectAtIndex:section]];
    return cityGroup.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return self.sectionHeaderHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    header.backgroundColor = [UIColor colorWithString:@"#e3e3e3"];
    UILabel * titleLB = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, ScreenWidth-30, 30)];
      [header addSubview:titleLB];
      titleLB.textColor = [UIColor colorWithString:@"#333333"];
      titleLB.font = [UIFont systemFontOfSize:17];
    titleLB.text = [self.indexData objectAtIndex:section];
    return header;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString *  CellIdentifier = @"CellIdentifier";
    UITableViewCell  * cell = [tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSDictionary *nameDict = [self.nameList objectAtIndex:indexPath.section];
    NSArray *nameGroup = [nameDict valueForKey:[self.indexData objectAtIndex:indexPath.section]];
    
    cell.textLabel.text = [nameGroup objectAtIndex:indexPath.row];
    return cell;
}

@end
