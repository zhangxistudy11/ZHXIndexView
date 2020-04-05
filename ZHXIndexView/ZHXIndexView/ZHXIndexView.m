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

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
                self.viewWidth = 25;

    }
    return self;
}
//- (instancetype)init {
//    if (self = [super init]) {
//        self.viewWidth = 25;
//    }
//
//    return self;
//}

//- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
//    [AZConvert convertForModel:self data:dic root:nil];
//    return YES;
//}

- (void)layoutSubviews {
//    WEAK_SELF;
    self.buttonHeight = (self.bounds.size.height - self.topOffset - self.bottomOffset)/self.indexButtons.count;
    for (NSInteger i = 0; i < self.indexButtons.count; i++) {
        UIButton *btn = self.indexButtons[i];
        if (i == 0) {
            /*
            [btn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf).offset(weakSelf.topOffset);
                make.centerX.equalTo(weakSelf);
                make.width.equalTo(weakSelf);
                make.height.mas_equalTo(weakSelf.buttonHeight);
            }];
             */
            btn.frame = CGRectMake(0, 30, 24, 20);
        } else {
            /*
            [btn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.indexButtons[i - 1].mas_bottom);
                make.centerX.equalTo(weakSelf);
                make.width.equalTo(weakSelf);
                make.height.mas_equalTo(weakSelf.buttonHeight);
            }];
             */
            UIButton *lastBtn = self.indexButtons[i - 1];
            btn.frame = CGRectMake(0, CGRectGetMaxY(lastBtn.frame), 24, 20);

        }
    }
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

- (void)setIndexTitles:(NSArray *)indexTitles {
    _indexTitles = indexTitles;
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    self.indexButtons = [self newIndexButtons];
}

- (NSMutableArray<UIButton *> *)newIndexButtons {
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

- (void)touchInsideAction:(NSSet<UITouch *> *)touches {
    NSArray *touchArray = touches.allObjects;
    UITouch *touch = touchArray.firstObject;
    CGPoint touchPoint = [touch locationInView:self];
    
    if (touchPoint.y <= self.topOffset || touchPoint.y >= self.bounds.size.height - self.bottomOffset) {
        return;
    }
    
    NSInteger buttonTag = (touchPoint.y - self.topOffset) / self.buttonHeight;
    
    [self.delegate touchInside:buttonTag];
}

- (void)setViewBackgroundColor:(UIColor *)viewBackgroundColor {
    _viewBackgroundColor = viewBackgroundColor;
    self.backgroundColor = _viewBackgroundColor;
}

// touch事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self touchInsideAction:touches];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self touchInsideAction:touches];
}


@end
