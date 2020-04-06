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
* The height of View . Size.hieght  is default value.
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
* The title size of item. Default is 13.0.
*/
@property(nonatomic, assign) CGFloat itemTitleSize;

/*If you need selected item backgroundColor ,Please implement follow property、method*/

/**
* The item backgroundcolor when selected. Default is nil.
*
*/
@property(nonatomic, strong) UIColor *itemSelectedBackgroundColor;

/// change select item backgroundcolor when scroll stop
/// @param index selectIndex
- (void)changeSelectIndexWhenScrollStop:(NSInteger)index;

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
