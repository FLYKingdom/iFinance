//
//  GradientView.m
//  Finance
//
//  Created by mac on 2018/7/1.
//  Copyright © 2018年 FlyYardAppStore. All rights reserved.
//

#import "GradientView.h"

@interface GradientView()

@property(nonatomic, assign) GradientStyle style;

@end

@implementation GradientView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
*/
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//}

- (void)drawGradientLayer:(UIColor *) bgColor{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    
    CGFloat red=0.0f;
    CGFloat green=0.0f;
    CGFloat blue=0.0f;
    CGFloat alpha=0.0f;
    [bgColor getRed:&red green:&green blue:&blue alpha:&alpha];
    
    //  创建渐变色数组，需要转换为CGColor颜色
    alpha = self.style == GradientStyleLeftRight ?1:0;
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:red green:green blue:blue alpha:alpha].CGColor,(__bridge id)[UIColor colorWithRed:red green:green blue:blue alpha:1-alpha].CGColor];
    //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    //  设置颜色变化点，取值范围 0.0~1.0
    gradientLayer.locations = @[@0,@1];
    
    gradientLayer.frame = self.bounds;
    [self.layer addSublayer:gradientLayer];
}

- (instancetype)initWithFrame:(CGRect)frame direction:(GradientStyle ) style
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI:style];
    }
    return self;
}

- (void)setupUI:(GradientStyle) style{
    self.style = style;
}



@end
