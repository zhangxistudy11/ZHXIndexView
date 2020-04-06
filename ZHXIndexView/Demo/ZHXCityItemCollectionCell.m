//
//  ZHXCityItemCollectionCell.m
//  ZHXIndexView
//
//  Created by 张玺 on 2020/4/4.
//  Copyright © 2020 张玺. All rights reserved.
//

#import "ZHXCityItemCollectionCell.h"
#import "UIColor+Extension.h"

@interface  ZHXCityItemCollectionCell()
@property (nonatomic, strong) UIView *backView;
@property(nonatomic,strong) UILabel *titleLB;
@end
@implementation ZHXCityItemCollectionCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpView];
    }
    return self;
}
- (void)setUpView{
    self.contentView.backgroundColor = [UIColor colorWithString:@"#f5f5f5"];
    
    self.backView = [[UIView alloc]init];
    [self.contentView addSubview:self.backView];
    
    self.backView = [[UIView alloc]initWithFrame:self.contentView.bounds];
    [self.contentView addSubview:self.backView];
    self.backView.layer.cornerRadius = 6.0;
    self.backView.backgroundColor = [UIColor whiteColor];
    
//    self.backView.layer.borderWidth = 1;
//    self.backView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.titleLB = [[UILabel alloc]initWithFrame:self.backView.bounds];
    [self.backView addSubview:self.titleLB];
    self.titleLB.textColor = [UIColor blackColor];
    self.titleLB.font = [UIFont systemFontOfSize:15];
    self.titleLB.textAlignment = NSTextAlignmentCenter;
 
}

- (void)updateCityName:(NSString *)cityName {
    self.titleLB.text = cityName;
}

@end
