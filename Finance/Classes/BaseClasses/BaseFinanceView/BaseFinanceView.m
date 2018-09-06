//
//  BaseFinanceView.m
//  Finance
//
//  Created by mac on 2018/6/25.
//  Copyright © 2018年 FlyYardAppStore. All rights reserved.
//

#import "BaseFinanceView.h"

#import "MyUtility.h"

@interface BaseFinanceView()

@property (nonatomic, strong) UIView *shadowContainer;

@end

@implementation BaseFinanceView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
        
        UIView *container = [[UIView alloc] initWithFrame:self.frame];
        self.shadowContainer = container;
        [MyUtility addShadowView:container Opacity:0.7];
        [container addSubview:self];
        
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(container);
        }];
    }
    return self;
}

@end
