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
* The title tintColor of item. Default is black.
*/
@property(nonatomic, strong) UIColor *titleColor;
/**
* The title size of item. Default is 13.0.
*/
@property(nonatomic, assign) CGFloat titleSize;
/**
* The view backgroundcolor. Default is clear.
*/
@property(nonatomic, strong) UIColor *contentBackgroundColor;



@end

NS_ASSUME_NONNULL_END
