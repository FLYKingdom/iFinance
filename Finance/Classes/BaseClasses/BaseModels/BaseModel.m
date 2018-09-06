//
//  BaseTableModel.m
//  zhaosha
//
//  Created by mac on 17/5/17.
//  Copyright © 2017年 Eels. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

- (void)encodeWithCoder:(NSCoder *)coder {
    
    NSArray *array = [self getProperties];
    
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        //
        NSString *key = obj;
        id value = [self valueForKey:key];
        if (value) {
            [coder encodeObject:[self valueForKey:key] forKey:key];
        }
    }];
    
}
- (id)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        NSArray *array = [self getProperties];
        
        [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            //
            NSString *key = obj;
            id value = [coder decodeObjectForKey:key];
            if (value) {
                [self setValue:value forKey:key];
            }
        }];
        
        
    }
    return self;
}
-(NSString *)description{
    
    NSArray *keys = [self getProperties];
    return [self dictionaryWithValuesForKeys:keys].description;
}

//字典转模型
+(instancetype)modelWithDictionary:(NSDictionary *)dict
{
    BaseModel *model = [[BaseModel  alloc] init];
    
    NSArray *array = [model getProperties];
    
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        //
        NSString *key = obj;
        id value = [dict objectForKey:key];
        if (value) {
            [model setValue:value forKey:key];
        }
    }];
    
    return model;
}

-(instancetype)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    
    if (self) {
        NSArray *array = [self getProperties];
        
        [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            //
            NSString *key = obj;
            id value = [dict objectForKey:key];
            if (value && ![value isKindOfClass:[NSNull class]]) {
                [self setValue:value forKey:key];
            }
        }];
        
        NSNumber *idNumerber = [dict objectForKey:@"id"];
        
        self.infoID = idNumerber?[idNumerber integerValue]:0;
    }
    
    
    return self;
}

//获取所有属性值
- (NSArray *)getProperties
{
    unsigned int count;
    
    objc_property_t *properties = class_copyPropertyList(self.class, &count);
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i =0; i< count ; i++) {
        
        objc_property_t pro = properties[i];
        
        const char *nameP = property_getName(pro);
        
        NSString *property = [[NSString alloc] initWithUTF8String:nameP];
        
        [array addObject:property];
    }
    free(properties);
    
    return array;
}

-(NSMutableDictionary *)translateIntoDict{
    NSMutableDictionary *infoDict = [NSMutableDictionary dictionary];
    
    NSArray *array = [self getProperties];
    
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        //
        NSString *key = obj;
        id value = [self valueForKey:key];
        if (value) {
            [infoDict setObject:value forKey:key];
        }
    }];
    
    return infoDict;
}

-(NSString *)getFormatFloatString:(NSString *)valueKey{
    
    return [self getFormatFloatString:valueKey precision:2];
}

-(NSString *)getFormatFloatString:(NSString *)valueKey precision:(int)precision{
    return [self getFormatFloatString:valueKey precision:precision sign:NO];
}

-(NSString *) getFormatFloatString:(NSString *)valueKey precision:(int)precision sign:(BOOL)sign{
    NSNumber *value = [self valueForKey:valueKey];
    
    if (!value || ![value isKindOfClass:[NSNumber class]]) {
        return 0;
    }
    
    CGFloat f = [value floatValue];
    
    NSString *signStr = @"";
    if (sign) {
        signStr = f>0? @"+":@"";
    }
    
    if (fmodf(f, 1)==0) {
        return [NSString stringWithFormat:@"%@%.0f",signStr,f];
    } else if (fmodf(f*10, 1)==0) {//如果有一位小数点
        return [NSString stringWithFormat:@"%@%.1f",signStr,f];
    }else if (fmodf(f*100, 1)==0) {//如果有两位小数点
        return [NSString stringWithFormat:@"%@%.2f",signStr,f];
    }
    //如果有三位小数点
    return [NSString stringWithFormat:@"%@%.3f",signStr,f];
}

-(NSString *)getFormatPercentString:(NSString *)valueKey precision:(int)precision sign:(BOOL)sign{
    NSString *tmpStr = [self getFormatFloatString:valueKey precision:precision sign:sign];
    
    return [tmpStr stringByAppendingString:@"%"];
}


-(NSString *)getFormatDateString:(NSString *)valueKey{
    NSNumber *value = [self valueForKey:valueKey];
    
    if (!value || ![value isKindOfClass:[NSNumber class]]) {
        return 0;
    }
    
    NSTimeInterval timestap = [value doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestap];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yy-MM-dd";
    
    return [formatter stringFromDate:date];
    
}

-(NSString *)getDaysWithBegin:(NSString *)beginKey end:(NSString *)endKey{
    
    NSNumber *beginValue = [self valueForKey:beginKey];
    NSNumber *endValue = [self valueForKey:endKey];
    
    if (!beginValue || !endValue || ![beginValue isKindOfClass:[NSNumber class]] || ![endValue isKindOfClass:[NSNumber class]]) {
        return @"30days";
    }
    
    NSTimeInterval beginTimestap = [beginValue doubleValue];
    NSTimeInterval endTimestap = [endValue doubleValue];
    NSTimeInterval time = endTimestap - beginTimestap;
    
    int days = ((int)time)/(3600*24);
    
    NSString *daysStr = [NSString stringWithFormat:@"%d天",days];
    
    return daysStr.length>0?daysStr:@"30days";
}

@end
