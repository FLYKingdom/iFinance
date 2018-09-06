//
//  GradientView.h
//  Finance
//
//  Created by mac on 2018/7/1.
//  Copyright © 2018年 FlyYardAppStore. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    GradientStyleLeftRight,
    GradientStyleRightLeft,
    GradientStyleTopBottom,
    GradientStyleBottomTop,
} GradientStyle;

@interface GradientView : UIView

- (instancetype)initWithFrame:(CGRect)frame direction:(GradientStyle ) style;

- (void)drawGradientLayer:(UIColor *) bgColor;

@end
