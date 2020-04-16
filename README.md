# ZHXIndexView
---------------------------------------------------------
[![](https://img.shields.io/badge/build-passing-brightgreen.svg)](https://github.com/zhangxistudy11/ZHXIndexView)
[![](https://img.shields.io/badge/tag-0.0.1-brightgreen.svg)](https://github.com/zhangxistudy11/ZHXIndexView/tree/0.0.1)
[![](https://img.shields.io/badge/language-ObjectC-brightgreen.svg)](https://github.com/zhangxistudy11/ZHXIndexView)
[![](https://img.shields.io/badge/中文-简书-brightgreen.svg)](https://www.jianshu.com/p/00a09e342062)
[![](https://img.shields.io/badge/IndexView-UICollectionView|UITableView-blue.svg)](https://github.com/zhangxistudy11/ZHXIndexView)




· A simple indexing tool for both UITableView and UICollectionVIew.

[中文文档地址](https://www.jianshu.com/p/00a09e342062)
# Table of Contents
---------------------------------------------------------
* [Background](#Background)
* [DisplayEffect](#DisplayEffect)
* [Install](#Install)
* [Usage](#Usage)
* [API](#API)
* [References](#References)
* [License](#License)


# Background
---------------------------------------------------------
Since the iOS system comes with a single index effect, and does not support UICollectionView. When you use it, you need to write it yourself. Although the code is not complicated, it is not necessary to reinvent the wheel. Here I provide a packaged ZHXIndexVeiew that supports UITableView and UICollectionView.

# DisplayEffect
---------------------------------------------------------

basics：

![image](https://github.com/zhangxistudy11/ZHXIndexView/blob/master/ZHXIndexView/Source/basic.gif)


highlight & no indicator：

![image](https://github.com/zhangxistudy11/ZHXIndexView/blob/master/ZHXIndexView/Source/highlight%26noIndicator.gif)

indicator & not highlighted of front

![image](https://github.com/zhangxistudy11/ZHXIndexView/blob/master/ZHXIndexView/Source/noHighlightInFront.gif)

for tableview:

![image](https://github.com/zhangxistudy11/ZHXIndexView/blob/master/ZHXIndexView/Source/tableview.gif)

# Install
---------------------------------------------------------
1. Download  [ZHXIndexView](https://github.com/zhangxistudy11/ZHXIndexView)
 and introduce ZHXIndexView.h and ZHXIndexView.m files into your project.
 The red content is the file you want to import, and the blue file is Demo, you can see my specific use.
 ![image]( https://github.com/zhangxistudy11/ZHXIndexView/blob/master/ZHXIndexView/Source/file-path.jpg)
2. If you use Cocoapods for your project, you can use the command line.
```
pod 'ZHXIndexView', '~> 0.0.1'
```

# Usage
---------------------------------------------------------
## Basic usage 
### Basic use: add indexView to the current page
```objectivec

     /*
     the frame here must be set correctly, the width and height of the indexView are determined here.
     The height of a single item is given by the (height/ indexTitles.count )
     */
    self.indexView = [[ZHXIndexView alloc]initIndexViewWithFrame:CGRectMake(ScreenWidth-24, 180, 24, 550)];
    [self.view addSubview:self.indexView];
    /*
     pay attention to setting the proxy method
     */
    self.indexView.delegate = self;
    self.indexView.itemTitleColor = [UIColor colorWithString:@"#999999"];
    self.indexView.itemTitleFont = [UIFont systemFontOfSize:10];
    /*
     Assigning values to data sources is best left behind to ensure that other required attributes have been assigned
     */
    self.indexView.indexTitles = self.indexData;
```

### At the same time to implement the proxy method

#### If UICollectionView , the proxy method is written as follows.
```objectivec
#pragma mark - ZHXIndexViewDelegate
- (void)indexViewDidSelectIndex:(NSInteger)index {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:index];
    CGFloat offsetY = [self.collectionView layoutAttributesForItemAtIndexPath:indexPath].frame.origin.y;
    //For better positioning, subtract the section height and the top spacing inside each section
    if (self.sectionHeaderHeight>0) {
        offsetY = offsetY - self.sectionHeaderHeight;
    }
    if (self.cellTopMargin>0) {
        offsetY = offsetY - self.cellTopMargin;
    }
    [self.collectionView setContentOffset:CGPointMake(0, offsetY) animated:NO];
}
```

#### If UITableView , the proxy method is written as follows.

```objectivec
#pragma mark - ZHXIndexViewDelegate
- (void)indexViewDidSelectIndex:(NSInteger)index {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:index];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
}
```
## Expanded usage

## First Case
### If the selected item needs to be highlighted, such as the second gif image, the background will be highlighted when the letter is selected.
#### Need to assign a value to this property

```objectivec
    self.indexView.itemHighlightColor = [UIColor colorWithString:@"#198CFF"];

```

#### In order to make the item stopped on a highlight when the scrolling ends, the proxy method of ScrollView needs to be implemented in the page


```objectivec
#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.indexView updateItemHighlightWhenScrollStopWithDispalyView:self.collectionView];
    });
}

```


## Second Case
### In some special scenes, if a certain item is selected without highlighting, such as the first three items of the third gif above, you need to assign values to the following attributes, and put the coordinate index that does not need to be highlighted into the array


```objectivec
    self.indexView.itemNoHighlightIndexArray = @[@(0),@(1),@(2)];

```

## Third Case
### When selected, with indicator: such as the  third and fourth gif


```objectivec
   self.indexView.showIndicatorView = YES;

```

 # API
---------------------------------------------------------

```objectivec
 
/// Initialization method
/// @param frame give the right values
- (instancetype)initIndexViewWithFrame:(CGRect)frame;
/**
* The delegate of indexView.
*/
@property(nonatomic, weak) id<ZHXIndexViewDelegate> delegate;

/**
* The data source of indexView.
*/
@property(nonatomic, strong) NSArray <NSString *>*indexTitles;

/**
* The view backgroundcolor. Default is clear.
*/
@property(nonatomic, strong) UIColor *contentBackgroundColor;

/**
* The title tintColor of item. Default is black.
*/
@property(nonatomic, strong) UIColor *itemTitleColor;
/**
* The title size of item. Default is [UIFont systemFontOfSize:13.0].
*/
@property(nonatomic, strong) UIFont *itemTitleFont;


/****************************************
 If you want the selected button to be highlighted, please implement the following properties and methods.
 ****************************************/

/**
* The  highlightColor when item is selected. Default is nil.
*
*/
@property(nonatomic, strong) UIColor *itemHighlightColor;
/**
 * The highlight item size. Default is MIN(item.width,item.height)/2 .
 */
@property(nonatomic, assign) CGFloat itemHighlightDiameter;
/**
 * The title tintColor of highlight  item. Default is white.
 */
@property(nonatomic, strong) UIColor *itemHighlightTitleColor;

/*
  Please note:
  This method needs to be called in '- (void)scrollViewDidScroll:(UIScrollView *)scrollView' in your page.
 */
/// change select item to highlightColor when scroll stop
/// @param displayView The view being displayed might be a collectionView or a tableView
- (void)updateItemHighlightWhenScrollStopWithDispalyView:(id)displayView;

/****************************************
If you need show sideways indicator view when you touch,Please implement follow property.
****************************************/

/**
* The display indicator. Default is YES .
*/
@property(nonatomic,assign) BOOL showIndicatorView;
/**
* The  indicator backgroundcolor. Default is "#0C0C0C"   70%.
*/
@property (nonatomic, strong) UIColor *indicatorBackgroundColor;
/**
* The  indicator textColor. Default is white.
*/
@property (nonatomic, strong) UIColor *indicatorTextColor;
/**
* The  indicator font. Default is 15.
*/
@property (nonatomic, strong) UIFont *indicatorTextFont;
/**
* The  indicator height. Default is 20.
*/
@property (nonatomic, assign) CGFloat indicatorHeight;
/**
* The  margin with content left . Default is 15.
*/
@property (nonatomic, assign) CGFloat indicatorRightMargin;
/**
* The  indicator cornerradius. Default is 10.
*/
@property (nonatomic, assign) CGFloat indicatorCornerRadius;

/****************************************
If you want not the selected button to be highlighted, please implement the following properties and methods.
****************************************/

/**
 * The item don't hightlight index .
 */
@property(nonatomic, strong) NSArray <NSNumber *>* itemNoHighlightIndexArray;

```

# References
---------------------------------------------------------
SCIndexView

# License
---------------------------------------------------------
MIT © Zhang Xi

