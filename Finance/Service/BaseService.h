//
//  BaseService.h
//  HaoyunDriver
//
//  Created by bingo on 14-8-4.
//  Copyright (c) 2014年 arteam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFBingoAPIClient.h"
#import "CacheManager.h"
#import "BaseModel.h"

#define SuccessCode 200

#define RespMeta @"meta"
#define RespDesc @"desc"
#define RespCode @"code"
#define RespData @"data"

@interface BaseService : NSObject


+(void) postService:(NSDictionary*)parameter URL:(NSString *)requestURL success:(void (^)(void ))sussessBlock fail:(void (^)(NSString *reason))failBlock;

+(void) addInfoService:(NSDictionary*)parameter URL:(NSString *)requestURL praseName:(NSString *) praseName success:(void (^)(NSInteger resultID ))sussessBlock fail:(void (^)(NSString *reason))failBlock;

//获取timeStamp 判断是否需要更新 数据
#pragma mark - base list detail request

+(void) getInfoListWithClass:(NSString *) modelClass key:(NSString *) key parameter:(NSDictionary *)  parameter URL:(NSString *) url success:(void (^)(NSArray *list))successBlock fail:(void(^)(NSString *reason)) failBlock;


/**
 获取列表页数据

 @param modelClass model class nil时返回数组
 @param key key description 解析使用到的关键字
 @param parameter parameter description
 @param url url description
 @param successBlock successBlock description
 @param failBlock failBlock description
 */
+(void) getInfoListWithClass:(NSString *) modelClass parameter:(NSDictionary *)  parameter URL:(NSString *) url success:(void (^)(NSArray *list))successBlock fail:(void(^)(NSString *reason)) failBlock;

+(void) getDetailInfoWithClass:(NSString *) modelClass key:(NSString *) key parameter:(NSDictionary *)  parameter URL:(NSString *) url success:(void (^)(BaseModel *detailInfo))successBlock fail:(void(^)(NSString *reason)) failBlock;

+(void) getDetailInfoWithClass:(NSString *) modelClass parameter:(NSDictionary *)  parameter URL:(NSString *) url success:(void (^)(BaseModel *detailInfo))successBlock fail:(void(^)(NSString *reason)) failBlock;

#pragma mark - uploadimage

+(void)updateImage:(UIImage *)cerImage fileName:(NSString *) fileName parameter:(NSDictionary *) paramter url:(NSString *) url progress:(void (^)(CGFloat))progressBlock success:(void (^)(id  callBackInfo))successBlock fail:(void (^)(NSString *reason))failBlock;

@end
