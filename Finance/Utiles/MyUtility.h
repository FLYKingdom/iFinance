//
//  Utility.h
//  xinlife
//
//  Created by qianxun on 13-8-6.
//  Copyright (c) 2013年 com.qianxun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface
MyUtility : NSObject
 
 
+(BOOL) connectedToNetwork;
 
+(BOOL)isvalidateEmail:(NSString*)email;
+(BOOL)isValidateString:(NSString *)myString;


+ (NSString*)fileAvataPathWithID:(NSString *)ID;


+(NSString *)getCSSandJSGray;
+(NSString *)getCSSandJSWhite;

+(NSString *)getServer;

/**
 *将日期字符串格式化
 */
+(NSString *)getFormatDate:(NSString *) originalDate;


/**
 *用最简短的格式显示两个日期的间隔
 */
+(NSString *)getSimpleSpanWithBegin:(NSString *) begin end:(NSString *)end isTimeExist:(bool) isTimeExist;

 /**
  * 将普通View变为高大上的CardView
  */
+(void) convert2CardView:(UIView *)view withCornerRadius:(int) radius borderWidth:(float ) borderWidth;


+(void) convert2BorderView:(UIView *) view;

+(void) addShadowView:(UIView *)view Opacity:(float) opacity;

+(UIView *) getShadowView:(UIView *)view Opacity:(float) opacity;//获取加投影的view

+(void) addShadowView:(UIView *)view radius:(float) radius size:(CGSize) size;

+(UIView *)addGradualMagicSep:(UIView *)targetView type:(NSInteger) type;

/**
 @method 获取指定宽度情况下，字符串value的size
 @param value 待计算的字符串
 @param fontSize 字体
 @param andWidth 限制字符串显示区域的宽度
 @result float 返回的size
 */
+(CGSize) rectForString:(NSString *)value font:(UIFont *) font andWidth:(float) width;

+ (float) heightForTextView: (UILabel *)label WithText: (NSString *) strText;

/**
 *缩放图片
 */
+(UIImage*)imageWithImage:(UIImage*)sourceImage scaledToSizeWithSameAspectRatio:(CGSize)targetSize;


+(void) flyIn:(UIView *) rootView;

/**
 * 随机获取颜色，用于消息列表图标背景色
 */
+ (UIColor *) getFlatUIColors;

#pragma mark - 二维码

+ (UIImage *)generateQRCode:(NSString *) urlString size:(CGFloat) size;

#pragma mark - TextField and TextView style

+(UITextField *) generateTextField:(NSString *) tipStr placeholder:(NSString *) placeholder frame:(CGRect) frame;

+(UITextView *) generateTextView:(NSString *) tipStr placeholder:(NSString *) placeholder frame:(CGRect) frame;

@end
