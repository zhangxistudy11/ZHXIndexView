//
//  ZHXIndexView.h
//  ZHXIndexView
//
//  Created by 张玺 on 2020/4/5.
//  Copyright © 2020 张玺. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ZHXIndexViewDelegate <NSObject>
@required

- (void)indexViewDidSelectIndex:(NSInteger)index;

@end


@interface ZHXIndexView : UIView

/**
* The delegate of indexView.
*/
@property(nonatomic, weak) id<ZHXIndexViewDelegate> delegate;

/**
* The data source of indexView.
*/
@property(nonatomic, strong) NSArray <NSString *>*indexTitles;

/**
* The height of View . Default is View.frame.size.height.
*/
@property(nonatomic,assign) float contentHeight;

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


/*
  Please note:
  This method needs to be called in '- (void)scrollViewDidScroll:(UIScrollView *)scrollView' in your page.
 */
/// change select item to highlightColor when scroll stop
/// @param displayView The view being displayed might be a collectionView or a tableView
- (void)updateItemHighlightWhenScrollStopWithDispalyView:(id)displayView;


/*If you need show right indicator view when you touch,Please implement follow property*/

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

@end

NS_ASSUME_NONNULL_END
