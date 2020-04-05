//
//  ZHXIndexView.m
//  ZHXIndexView
//
//  Created by 张玺 on 2020/4/5.
//  Copyright © 2020 张玺. All rights reserved.
//

#import "ZHXIndexView.h"

@interface ZHXIndexView ()
@property(nonatomic, strong) NSMutableArray<UIButton *> *indexButtons;
@property(nonatomic, assign) CGFloat buttonHeight;
@end

@implementation ZHXIndexView
#pragma mark - LifeCycle Method
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentHeight = CGRectGetHeight(self.frame);
        self.titleColor = [UIColor blackColor];
        self.titleSize = 13.0;
    }
    return self;
}

- (void)layoutSubviews {
    self.buttonHeight = self.contentHeight/self.indexButtons.count;
       for (NSInteger i = 0; i < self.indexButtons.count; i++) {
           UIButton *btn = self.indexButtons[i];
           if (i == 0) {
               btn.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), self.buttonHeight);
           } else {
               UIButton *lastBtn = self.indexButtons[i - 1];
               btn.frame = CGRectMake(0, CGRectGetMaxY(lastBtn.frame), CGRectGetWidth(self.frame), self.buttonHeight);
           }
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
- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    for (UIButton *btn in self.indexButtons) {
        [btn setTitleColor:_titleColor forState:UIControlStateNormal];
    }
}

- (void)setTitleSize:(CGFloat)titleSize {
    _titleSize = titleSize;
    for (UIButton *btn in self.indexButtons) {
        btn.titleLabel.font = [UIFont systemFontOfSize: _titleSize];
    }
}
- (void)setContentBackgroundColor:(UIColor *)contentBackgroundColor {
    _contentBackgroundColor = contentBackgroundColor;
    self.backgroundColor = contentBackgroundColor;
}


#pragma mark - Private Method
- (NSMutableArray<UIButton *> *)creatAllButtons {
    for (UIButton *old in self.indexButtons) {
        [old removeFromSuperview];
    }
    
    NSMutableArray<UIButton *> *buttons = [NSMutableArray array];
    
    for (NSInteger i = 0; i < self.indexTitles.count; i++) {
        NSString *title = self.indexTitles[i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.tag = i;
        if (self.titleColor) {
            [btn setTitleColor:_titleColor forState:UIControlStateNormal];
        }
        if (self.titleSize > 0) {
            btn.titleLabel.font = [UIFont systemFontOfSize: _titleSize];
        }
        [btn setTitle:title forState:UIControlStateNormal];
        btn.userInteractionEnabled = NO;
        [self addSubview:btn];
        
        [buttons addObject:btn];
    }
    
    return buttons;
}
#pragma mark - Event Method
- (void)touchInsideAction:(NSSet<UITouch *> *)touches {
    NSArray *touchArray = touches.allObjects;
    UITouch *touch = touchArray.firstObject;
    CGPoint touchPoint = [touch locationInView:self];
    NSInteger buttonTag = touchPoint.y  / self.buttonHeight;
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


@end
