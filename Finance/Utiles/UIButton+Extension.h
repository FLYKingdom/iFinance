//
//  UIButton+Extension.h
//  zhaosha
//
//  Created by mac on 15/12/24.
//  Copyright © 2015年 Eels. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)

+(instancetype)buttonWithName:(NSString *) name andFont:(CGFloat) font color:(UIColor *) color cornerRadius:(CGFloat) cornerRadius;

+(instancetype)buttonWithName:(NSString *) name andFont:(CGFloat) font HexColor:(NSString *) hexString cornerRadius:(CGFloat) cornerRadius;

+(instancetype)buttonWithName:(NSString *) name andFont:(CGFloat) font HexColor:(NSString *) hexString;

+(instancetype)buttonWithName:(NSString *) name andFont:(CGFloat) font andUIColor:(UIColor *) color;

+(instancetype)buttonWithName:(NSString *) name boldFont:(CGFloat) font HexColor:(NSString *) hexString;

+(instancetype)buttonDefaultStyle:(NSString *) name;

+(instancetype)buttonDefaultStyle:(NSString *)name bgColor:(UIColor *) color;

+(instancetype)buttonDefaultBorderStyle:(NSString *) name;

+(instancetype)buttonWithImage:(NSString *) imagePath disableImg:(NSString *) disablePath;

+(instancetype)buttonWithImage:(NSString *)imagePath selectedImg:(NSString *)selectedPath;

@end
