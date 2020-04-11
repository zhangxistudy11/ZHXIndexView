//
//  ZHXIndexItemView.m
//  ZHXIndexView
//
//  Created by 张玺 on 2020/4/11.
//  Copyright © 2020 张玺. All rights reserved.
//

#import "ZHXIndexItemView.h"

@interface ZHXIndexItemView()

@end
@implementation ZHXIndexItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpView];
    }
    return self;
}
- (void)setUpView {
    
    self.badge = [[UIView alloc]init];
    [self addSubview:self.badge];
    
    self.contntLB = [[UILabel alloc]init];
    [self addSubview:self.contntLB];

}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat badgeWH = MIN(self.frame.size.width, self.frame.size.height);
    self.badge.frame = CGRectMake(self.frame.size.width/2-badgeWH/2, self.frame.size.height/2-badgeWH/2, badgeWH, badgeWH);
    self.badge.layer.cornerRadius = badgeWH/2;
    
    self.contntLB.frame = self.bounds;
    self.contntLB.textAlignment = NSTextAlignmentCenter;
    
}
@end
