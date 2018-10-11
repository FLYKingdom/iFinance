//
//  ZSCacheManager.h
//  zhaosha
//
//  Created by mac on 16/10/19.
//  Copyright © 2016年 Eels. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *PlatformHoldTableKey = @"PlatformHoldTableKey";
static NSString *PlatformInfoTableKey = @"PlatformInfoTableKey";


@interface CacheManager : NSObject

#pragma 账号相关存储

+(void)saveInfoWithKey:(id)info key:(NSString *) key;

+(id) getInfoWithKey:(NSString *) key;

#pragma 获取版本号

//+(NSString *) getCurrentVersion;

#pragma mark - setting 清除缓存 和 缓存计算

+(void) clearCacheOnCompletion:(void (^)(BOOL successed))completion;
+(void) calculateSizeWithCompletionBlock:(void (^)(NSString *totalSize)) completion;

#pragma mark - platform

+(void) initializePlatformTable;

@end
