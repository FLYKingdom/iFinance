//
//  UILabel+Extension.m
//  zhaosha
//
//  Created by mac on 15/12/30.
//  Copyright © 2015年 Eels. All rights reserved.
//

#import "UILabel+Extension.h"
#import "HexColor.h"

@implementation UILabel (Extension)
+(UILabel *)labelWithName:(NSString *) name{
    UILabel *lab = [UILabel new];
    if (name == nil || [name isKindOfClass:[NSNull class]]) {
        name = @"";
    }
    [lab setText:name];
    [lab setTextColor:[UIColor blackColor]];
    [lab sizeToFit];
    return lab;
}

+(UILabel *)labelWithGrayName:(NSString *)name{
    UILabel *lab = [UILabel new];
    if (name == nil || [name isKindOfClass:[NSNull class]]) {
        name = @"";
    }
    [lab setText:name];
    [lab setTextColor:[UIColor grayColor]];
    [lab sizeToFit];
    return lab;
}

+(UILabel *)labelWithName:(NSString *)name textColor:(UIColor *) textcolor
          backGroundColor:(UIColor *)backColor{
    UILabel *lab = [UILabel new];
    if (name == nil || [name isKindOfClass:[NSNull class]]) {
        name = @"";
    }
    [lab setText:name];
    [lab setTextColor:textcolor];
    [lab setBackgroundColor:backColor];
    [lab sizeToFit];
    
    return lab;
}

+(UILabel *)labelWithName:(NSString *)name
                 fontSize:(CGFloat) fontSize
                textColor:(UIColor *) textcolor
          backGroundColor:(UIColor *)backColor{
    UILabel *lab = [UILabel new];
    if (name == nil || [name isKindOfClass:[NSNull class]]) {
        name = @"";
    }
    [lab setText:name];
    [lab setFont:[UIFont systemFontOfSize:fontSize]];
    [lab setTextColor:textcolor];
    [lab setBackgroundColor:backColor];
    [lab sizeToFit];
    
    return lab;
}

+(UILabel *)labelWithName:(NSString *)name fontSize:(CGFloat)font fontColor:(UIColor *)color{
    UILabel *lab = [UILabel new] ;
    if (name == nil || [name isKindOfClass:[NSNull class]]) {
        name = @"";
    }
    [lab setText:name];
    [lab setTextColor:color];
    [lab setFont:[UIFont systemFontOfSize:font]];
    [lab sizeToFit];
    
    return lab;
}

+(UILabel *)labelWithName:(NSString *)name
                 fontSize:(CGFloat) font
             fontHexColor:(NSString *) hexStr{
    UILabel *lab = [UILabel new] ;
    if (name == nil || [name isKindOfClass:[NSNull class]]) {
        name = @"";
    }
    [lab setText:name];
    UIColor *fontColor = [HexColor colorWithHexString:hexStr];
    [lab setTextColor:fontColor];
    [lab setFont:[UIFont systemFontOfSize:font]];
    [lab sizeToFit];
    
    return lab;
}

+(UILabel *)labelWithName:(NSString *)name
                 boldSize:(CGFloat) font
             fontHexColor:(NSString *) hexStr{
    UILabel *lab = [UILabel new] ;
    if (name == nil) {
        name = @"";
    }
    [lab setText:name];
    UIColor *fontColor = [HexColor colorWithHexString:hexStr];
    [lab setTextColor:fontColor];
    [lab setFont:[UIFont fontWithName:BoldFontName size:font]];
    [lab sizeToFit];
    
    return lab;
}

+(UILabel *)labelWithName:(NSString *)name fontSize:(CGFloat)fontSize fontName:(NSString *)fontName fontColor:(UIColor *)color{
    UILabel *lab = [UILabel new] ;
    if (name == nil) {
        name = @"";
    }
    [lab setText:name];
    [lab setTextColor:color];
    [lab setFont:[UIFont fontWithName:fontName size:fontSize]];
    [lab sizeToFit];
    
    return lab;
}


-(void)setTextAddSizeToFit:(NSString *)textName{
    textName = textName&&![textName isEqualToString:@""] ?textName:@"暂无信息";
    [self setText:textName];
    [self sizeToFit];
}

//+(UILabel *)labelWithName:(NSString *)name
//                 fontSize:(CGFloat) font
//                fontColor:(UIColor *) color paragraphSep:(CGFloat) sep{
//    
//}

//+(UILabel *)labelWithName:(NSString *)name
//                 fontSize:(CGFloat) font
//                fontColor:(UIColor *) color paragraphSep:(CGFloat) sep lineSep:(CGFloat) lineSep{
//    UILabel *lab = [UILabel new] ;
//    if (name == nil || [name isKindOfClass:[NSNull class]]) {
//        name = @"";
//    }
//    NSMutableAttributedString *attributedStr = [MyUtility getAttributedString:name font:font color:color andUnderline:NO];
//    NSMutableParagraphStyle *pragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    pragraphStyle.paragraphSpacing = sep;
//    pragraphStyle.lineSpacing = lineSep;
//    NSRange range = NSMakeRange(0, name.length);
//    [attributedStr addAttribute:NSParagraphStyleAttributeName value:pragraphStyle range:range];
//    lab.attributedText = attributedStr;
//    
//    [lab sizeToFit];
//    
//    return lab;
//}
//
//+(UILabel *)labelWithName:(NSString *)name
//                 fontSize:(CGFloat) font
//             fontHexColor:(NSString *) hexStr paragraphSep:(CGFloat) sep lineSep:(CGFloat)lineSep{
//    UILabel *lab = [UILabel new] ;
//    if (name == nil || [name isKindOfClass:[NSNull class]]) {
//        name = @"";
//    }
//    UIColor *fontColor = [HexColor colorWithHexString:hexStr];
//    NSMutableAttributedString *attributedStr = [MyUtility getAttributedString:name font:font color:fontColor andUnderline:NO];
//     NSMutableParagraphStyle *pragraphStyle = [[NSMutableParagraphStyle alloc] init];
//     pragraphStyle.paragraphSpacing = sep;
//    pragraphStyle.lineSpacing = lineSep;
//     NSRange range = NSMakeRange(0, name.length);
//     [attributedStr addAttribute:NSParagraphStyleAttributeName value:pragraphStyle range:range];
//     lab.attributedText = attributedStr;
//    
//    return lab;
//}

@end
