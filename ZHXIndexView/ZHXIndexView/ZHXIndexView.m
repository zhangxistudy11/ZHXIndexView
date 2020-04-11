//
//  ZHXIndexView.m
//  ZHXIndexView
//
//  Created by 张玺 on 2020/4/5.
//  Copyright © 2020 张玺. All rights reserved.
//

#import "ZHXIndexView.h"
#import "ZHXIndexItemView.h"

@interface ZHXIndexView ()
@property(nonatomic, strong) NSMutableArray<ZHXIndexItemView *> *indexButtons;
@property(nonatomic, assign) CGFloat buttonHeight;
@property(nonatomic,assign) NSInteger selectedIndex;
@property (nonatomic, strong) UILabel *indicatorView;

@end

@implementation ZHXIndexView
#pragma mark - LifeCycle Method
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentHeight = CGRectGetHeight(self.frame);
        self.itemTitleColor = [UIColor blackColor];
        self.itemTitleFont = [UIFont systemFontOfSize:13.0];
        self.selectedIndex = 0;
        self.showIndicatorView = YES;
        self.indicatorBackgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5 ];
        self.indicatorTextColor = [UIColor whiteColor];
        self.indicatorTextFont = [UIFont systemFontOfSize:15];
        self.indicatorHeight = 30.0;
        self.indicatorRightMargin = 10.0;
        self.indicatorCornerRadius = 10.0;
        
    }
    return self;
}

- (void)layoutSubviews {
    self.buttonHeight = self.contentHeight/self.indexButtons.count;
    for (NSInteger i = 0; i < self.indexButtons.count; i++) {
        ZHXIndexItemView *btn = self.indexButtons[i];
        if (i == 0) {
            btn.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), self.buttonHeight);
        } else {
            ZHXIndexItemView *lastBtn = self.indexButtons[i - 1];
            btn.frame = CGRectMake(0, CGRectGetMaxY(lastBtn.frame), CGRectGetWidth(self.frame), self.buttonHeight);
        }
    }
    if (self.showIndicatorView) {
        [self addSubview:self.indicatorView];
    }
    
}
#pragma mark - Setter Method
- (void)setIndexTitles:(NSArray<NSString *> *)indexTitles{
    _indexTitles = indexTitles;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.indexButtons = [self creatAllButtons];
    
}
- (void)setContentHeight:(float)contentHeight{
    _contentHeight = contentHeight;
}
- (void)setItemTitleColor:(UIColor *)itemTitleColor {
    _itemTitleColor = itemTitleColor;
    for (ZHXIndexItemView *btn in self.indexButtons) {
        [btn setTitleColor:_itemTitleColor forState:UIControlStateNormal];
    }
}

- (void)setItemTitleFont:(UIFont *)itemTitleFont{
    _itemTitleFont = itemTitleFont;
    for (ZHXIndexItemView *btn in self.indexButtons) {
        btn.contntLB.font = _itemTitleFont;
    }
}

- (void)setContentBackgroundColor:(UIColor *)contentBackgroundColor {
    _contentBackgroundColor = contentBackgroundColor;
    self.backgroundColor = contentBackgroundColor;
}
- (void)setItemHighlightColor:(UIColor *)itemHighlightColor{
    _itemHighlightColor = itemHighlightColor;
 
}
- (void)setShowIndicatorView:(BOOL)showIndicatorView
{
    _showIndicatorView = showIndicatorView;
}

#pragma mark - Public Method
- (void)updateItemHighlightWhenScrollStopWithDispalyView:(id)displayView {
    NSInteger index = [self determineTopSectionOnDispalyView:displayView];
    [self changeSelectItemColorWithIndex:index];
}

#pragma mark - Private Method
- (NSInteger)determineTopSectionOnDispalyView:(id)displayView{
    if ([displayView isKindOfClass:[UICollectionView class]]) {
        UICollectionView *collectionView = displayView;
        NSArray *indexPathsForVisibleRows= collectionView.indexPathsForVisibleItems;
        NSIndexPath *minIndexPath = [NSIndexPath indexPathForRow:0 inSection:9999];
        for (int i=0; i<indexPathsForVisibleRows.count; i++) {
            NSIndexPath *itemIndex = [indexPathsForVisibleRows objectAtIndex:i];
            minIndexPath = [itemIndex compare:minIndexPath]==NSOrderedDescending?minIndexPath:itemIndex;
            
        }
        return minIndexPath.section;
    }else if ([displayView isKindOfClass:[UITableView class]]){
        UITableView *tableView = displayView;
        
        NSArray *indexPathsForVisibleRows= tableView.indexPathsForVisibleRows;
        NSIndexPath *minIndexPath = [NSIndexPath indexPathForRow:0 inSection:9999];
        
        for (int i=0; i<indexPathsForVisibleRows.count; i++) {
            NSIndexPath *itemIndex = [indexPathsForVisibleRows objectAtIndex:i];
            minIndexPath = [itemIndex compare:minIndexPath]==NSOrderedDescending?minIndexPath:itemIndex;
            
        }
        return minIndexPath.section;
    }else{}
    return 0;
    
}
- (NSMutableArray<ZHXIndexItemView *> *)creatAllButtons {
    for (ZHXIndexItemView *old in self.indexButtons) {
        [old removeFromSuperview];
    }
    
    NSMutableArray<ZHXIndexItemView *> *buttons = [NSMutableArray array];
    
    for (NSInteger i = 0; i < self.indexTitles.count; i++) {
        NSString *title = self.indexTitles[i];
        ZHXIndexItemView *btn = [ZHXIndexItemView buttonWithType:UIButtonTypeSystem];
        btn.tag = i;
        if (self.itemTitleColor) {
            btn.contntLB.textColor = self.itemTitleColor;
        }
        if (self.itemTitleFont) {
            btn.contntLB.font = self.itemTitleFont;
        }
        btn.contntLB.text = title;
        btn.userInteractionEnabled = NO;
        [self addSubview:btn];
        
        [buttons addObject:btn];
    }
    
    return buttons;
}
- (void)changeSelectItemColorWithIndex:(NSInteger)index{
    self.selectedIndex = index;
    for (int i=0; i<self.indexButtons.count; i++) {
        ZHXIndexItemView *btn = [self.indexButtons objectAtIndex:i];
        if (i==self.selectedIndex) {
            btn.badge.backgroundColor = self.itemHighlightColor;
        }else{
            btn.badge.backgroundColor = [UIColor clearColor];
        }
    }
}
#pragma mark - Getter Method
- (UILabel *)indicatorView
{
    if (!_indicatorView) {
        _indicatorView = [[UILabel alloc]init];
        _indicatorView.textColor = self.indicatorTextColor;
        _indicatorView.font = self.indicatorTextFont;
        _indicatorView.textAlignment = NSTextAlignmentCenter;
        _indicatorView.backgroundColor = self.indicatorBackgroundColor;
        _indicatorView.hidden = YES;
        
        CGFloat indicatorRadius = self.indicatorHeight/ 2;
        CGFloat sinPI_4_Radius = sin(M_PI_4) * indicatorRadius;
        _indicatorView.bounds = CGRectMake(0, 0, (4 * sinPI_4_Radius), 2 * indicatorRadius);
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.path = [self drawIndicatorPath].CGPath;
        _indicatorView.layer.mask = maskLayer;
    }
    return _indicatorView;
}
- (UIBezierPath *)drawIndicatorPath
{
    CGFloat indicatorRadius = self.indicatorHeight / 2;
    CGFloat sinPI_4_Radius = sin(M_PI_4) * indicatorRadius;
    CGFloat margin = (sinPI_4_Radius * 2 - indicatorRadius);
    
    CGPoint startPoint = CGPointMake(margin + indicatorRadius + sinPI_4_Radius, indicatorRadius - sinPI_4_Radius);
    CGPoint trianglePoint = CGPointMake(4 * sinPI_4_Radius, indicatorRadius);
    CGPoint centerPoint = CGPointMake(margin + indicatorRadius, indicatorRadius);
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:startPoint];
    [bezierPath addArcWithCenter:centerPoint radius:indicatorRadius startAngle:-M_PI_4 endAngle:M_PI_4 clockwise:NO];
    [bezierPath addLineToPoint:trianglePoint];
    [bezierPath addLineToPoint:startPoint];
    [bezierPath closePath];
    return bezierPath;
}
- (void)showIndicatorWithIndex:(NSInteger )index{
    if (!self.showIndicatorView) {
        return;
    }
    ZHXIndexItemView *btn = [self.indexButtons objectAtIndex:index];
    self.indicatorView.center = CGPointMake(-(self.indicatorRightMargin+self.indicatorHeight), btn.center.y);
    self.indicatorView.text = [self.indexTitles objectAtIndex:index];
    self.indicatorView.alpha = 1;
    self.indicatorView.hidden = NO;
}
- (void)hideIndicator {
    if (!self.showIndicatorView) {
        return;
    }
    [UIView animateWithDuration:0.15 animations:^{
        self.indicatorView.alpha = 0;
    } completion:^(BOOL finished) {
        self.indicatorView.alpha = 1;
        self.indicatorView.hidden = YES;
    }];
}
#pragma mark - Event Method
- (void)touchInsideAction:(NSSet<UITouch *> *)touches {
    NSArray *touchArray = touches.allObjects;
    UITouch *touch = touchArray.firstObject;
    CGPoint touchPoint = [touch locationInView:self];
    NSInteger buttonTag = touchPoint.y  / self.buttonHeight;
    [self changeSelectItemColorWithIndex:buttonTag];
    
    [self showIndicatorWithIndex:buttonTag];
    if ([self.delegate respondsToSelector:@selector(indexViewDidSelectIndex:)]) {
        [self.delegate indexViewDidSelectIndex:buttonTag];
    }
}

#pragma mark - System Touch Method
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self touchInsideAction:touches];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self touchInsideAction:touches];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    if (!self.showIndicatorView) {
        return;
    }
    if (self.indicatorView.hidden) {
        return;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hideIndicator];
    });
}

@end
