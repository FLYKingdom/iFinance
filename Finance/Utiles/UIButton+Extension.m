//
//  UIButton+Extension.m
//  zhaosha
//
//  Created by mac on 15/12/24.
//  Copyright © 2015年 Eels. All rights reserved.
//

#import "UIButton+Extension.h"
#import "HexColor.h"

@implementation UIButton (Extension)

+(instancetype)buttonWithName:(NSString *) name andFont:(CGFloat) font HexColor:(NSString *) hexString{
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:name forState:UIControlStateNormal];
    UIColor *color = [HexColor colorWithHexString:hexString];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:font]];
   
    return btn;
}
+(instancetype)buttonWithName:(NSString *) name andFont:(CGFloat) font andUIColor:(UIColor *) color{
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:name forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:font]];
    
    return btn;
}


+(instancetype)buttonWithName:(NSString *)name boldFont:(CGFloat)font HexColor:(NSString *)hexString{
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:name forState:UIControlStateNormal];
    UIColor *color = [HexColor colorWithHexString:hexString];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont fontWithName:BoldFontName size:font]];
    
    return btn;
}

+(instancetype)buttonWithName:(NSString *)name andFont:(CGFloat)font HexColor:(NSString *)hexString cornerRadius:(CGFloat)cornerRadius{
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:name forState:UIControlStateNormal];
    UIColor *color = [HexColor colorWithHexString:hexString];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:font]];
    
    if (cornerRadius != 0) {
        CALayer *layer = btn.layer;
        [layer setMasksToBounds:YES];
        [layer setCornerRadius:cornerRadius];
    }
    
    return btn;
}



+(instancetype)buttonWithName:(NSString *)name andFont:(CGFloat)font color:(UIColor *)color cornerRadius:(CGFloat)cornerRadius{
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:name forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont fontWithName:FontName size:font]];
    if (cornerRadius != 0) {
        CALayer *layer = btn.layer;
        [layer setMasksToBounds:YES];
        [layer setCornerRadius:cornerRadius];
    }
    
    return btn;
}

+(instancetype)buttonDefaultStyle:(NSString *)name{
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:name forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont  systemFontOfSize:18]];
    [btn setBackgroundColor:DefaultMainColor];
    btn.clipsToBounds = YES;
    btn.layer.cornerRadius = 5.0f;
    
    return btn;
}

+(instancetype)buttonDefaultBorderStyle:(NSString *)name{
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:name forState:UIControlStateNormal];
    [btn setTitleColor:DefaultMainColor forState:UIControlStateNormal];
    [btn setTitle:name forState:UIControlStateHighlighted];
    [btn setTitleColor:DefaultMainColor forState:UIControlStateHighlighted];
    
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    
    CALayer *layer = btn.layer;
    [layer setCornerRadius:5];
    layer.borderColor = DefaultMainColor.CGColor;
    layer.borderWidth = 0.5;
    
    return btn;
}

+(instancetype)buttonWithImage:(NSString *)imagePath disableImg:(NSString *)disablePath{
    UIButton *btn = [[UIButton alloc] init];
    UIImage *normalImg = [UIImage imageNamed:imagePath];
    UIImage *disableImg = [UIImage imageNamed:disablePath];
    
    [btn setImage:normalImg forState:UIControlStateNormal];
    [btn setImage:disableImg forState:UIControlStateDisabled];
    
    return btn;
    
}

+(instancetype)buttonWithImage:(NSString *)imagePath selectedImg:(NSString *)selectedPath{
    UIButton *btn = [[UIButton alloc] init];
    UIImage *normalImg = [UIImage imageNamed:imagePath];
    UIImage *disableImg = [UIImage imageNamed:selectedPath];
    
    [btn setImage:normalImg forState:UIControlStateNormal];
    [btn setImage:disableImg forState:UIControlStateSelected];
    
    return btn;
    
}

@end
