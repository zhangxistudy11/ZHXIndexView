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

- (void)touchInside:(NSInteger)index;

@end


@interface ZHXIndexView : UIView
@property(nonatomic, strong) NSArray *indexTitles;

@property(nonatomic, strong) UIColor *titleColor;
@property(nonatomic, assign) CGFloat titleSize;
@property(nonatomic, assign) CGFloat viewWidth;
@property(nonatomic, strong) UIColor *viewBackgroundColor;

// topOffset和bottomOffset这两个属性只有在build版本号>7610时才可以使用，之前的版本oc有bug，会导致崩溃
@property(nonatomic, assign) CGFloat topOffset; // 侧边目录首个item距view的上间距
@property(nonatomic, assign) CGFloat bottomOffset;// 侧边目录末个item距view的下间距

@property(nonatomic, weak) id<ZHXIndexViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
