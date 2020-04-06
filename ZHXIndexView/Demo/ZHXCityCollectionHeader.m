//
//  ZHXCityCollectionHeader.m
//  ZHXIndexView
//
//  Created by 张玺 on 2020/4/4.
//  Copyright © 2020 张玺. All rights reserved.
//
#define ScreenWidth     [UIScreen mainScreen].bounds.size.width
#define ScreenHeight     [UIScreen mainScreen].bounds.size.height
#import "ZHXCityCollectionHeader.h"
#import "UIColor+Extension.h"

@interface  ZHXCityCollectionHeader()
@property(nonatomic,strong) UILabel *titleLB;
@end

@implementation ZHXCityCollectionHeader


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpView];
    }
    return self;
}
- (void)setUpView{
    self.backgroundColor = [UIColor colorWithString:@"#e3e3e3"];
    self.titleLB = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, ScreenWidth-30, 30)];
    [self addSubview:self.titleLB];
    self.titleLB.textColor = [UIColor colorWithString:@"#333333"];
    self.titleLB.font = [UIFont systemFontOfSize:17];
}
- (void)updateCityIndex:(NSString *)cityName {
    self.titleLB.text = cityName;
}
@end
