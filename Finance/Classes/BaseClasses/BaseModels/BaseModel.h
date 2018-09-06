//
//  BaseModel.h
//  zhaosha
//
//  Created by mac on 17/5/17.
//  Copyright © 2017年 Eels. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <objc/runtime.h>

@interface BaseModel : NSObject<NSCoding>

@property (nonatomic, assign) NSInteger infoID;//使用BaseModel时 必须设置 infoID

//sub class 可以重写的 mehtod

+(instancetype) modelWithDictionary:(NSDictionary *) dict;//public method

-(instancetype) initWithDictionary:(NSDictionary *) dict;//public method

- (NSArray *)getProperties;//sub class可以调用

-(NSMutableDictionary *) translateIntoDict;

#pragma mark format function

-(NSString *) getFormatFloatString:(NSString *) valueKey;

//最多3位小数
-(NSString *) getFormatFloatString:(NSString *) valueKey precision:(int) precision;

//是否显示正负号
-(NSString *) getFormatFloatString:(NSString *) valueKey
                                precision:(int) precision
                                     sign:(BOOL) sign;
//最多3位小数
-(NSString *) getFormatPercentString:(NSString *) valueKey precision:(int) precision
                                sign:(BOOL) sign;;

-(NSString *) getFormatDateString:(NSString *) valueKey;

-(NSString *) getDaysWithBegin:(NSString *) beginKey end:(NSString *) endKey;

@end
