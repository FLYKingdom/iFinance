//
//  ZSCacheManager.m
//  zhaosha
//
//  Created by mac on 16/10/19.
//  Copyright © 2016年 Eels. All rights reserved.
//

#import "CacheManager.h"

#import "PlatformModel.h"
#import "TMCache.h"

@implementation CacheManager

#pragma mark - user info

+(void)saveInfoWithKey:(id)info key:(NSString *) key{
    [[TMCache sharedCache] setObject:info forKey:key];
}

+(id)getInfoWithKey:(NSString *)key{
    return [[TMCache sharedCache] objectForKey:key];
}

#pragma mark - 计算缓存 和 清除缓存

+(void)clearCacheOnCompletion:(void (^)(BOOL))completion{
    NSString *localPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject;
    NSString *filePath = [localPath stringByAppendingFormat:@"/appdata/chatbuffer/17dushu"];
    
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:filePath];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath=[filePath stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    
    
    NSArray *essentialKeyArr = @[PlatformHoldTableKey,PlatformInfoTableKey];
    NSMutableDictionary *tmpDict = [NSMutableDictionary dictionaryWithCapacity:essentialKeyArr.count];
    for (NSString *key in essentialKeyArr) {
        id value = [self getInfoWithKey:key];
        if (value) {
            [tmpDict setObject:value forKey:key];
        }
    }
    
    [[TMCache sharedCache] removeAllObjects];
    
    //recover info
    for (NSString *key in essentialKeyArr) {
        id value = [tmpDict objectForKey:key];
        if (value) {         
            [self saveInfoWithKey:value key:key];
        }
    }
    
}

+(void)calculateSizeWithCompletionBlock:(void (^)(NSString *))completion{
    
    NSString *localPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject;
    NSString *filePath = [localPath stringByAppendingFormat:@"/appdata/chatbuffer/17dushu"];
    
    NSFileManager *fileManager=[NSFileManager defaultManager];
    float folderSize = 0;
    if ([fileManager fileExistsAtPath:filePath]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:filePath];
        for (NSString *fileName in childerFiles) {
            NSString *absolutePath=[filePath stringByAppendingPathComponent:fileName];
            
            if([fileManager fileExistsAtPath:absolutePath]){
                long long size=[fileManager attributesOfItemAtPath:absolutePath error:nil].fileSize;
                folderSize += size;
            }
        }
    }
//    //SDWebImage框架自身计算缓存的实现
//    [[SDImageCache sharedImageCache] calculateSizeWithCompletionBlock:^(NSUInteger fileCount, NSUInteger totalSize) {
//
//        totalSize += folderSize;
//        CGFloat total = totalSize/1024;
//        if (total>1024) {
//            total /= 1024;
//            NSLog(@"totalsize = %fM",total);
//            NSString *cacheStr = [NSString stringWithFormat:@"%.2fM",total];
//            if (completion) {
//                completion(cacheStr);
//            }
//
//        }else{
//            NSLog(@"totalsize = %fK",total);
//            NSString *cacheStr;
//            if (total<= 0.001) {
//                cacheStr = @"0M";
//            }else{
//                cacheStr = [NSString stringWithFormat:@"%.2fk",total];
//            }
//            if (completion) {
//                completion(cacheStr);
//            }
//        }
//
//    }];
}

#pragma mark - platform

+(void)initializePlatformTable{
    
    NSArray *platforms = [[TMCache sharedCache] objectForKey:PlatformInfoTableKey];
    
    if (platforms.count == 0) {
        
        //total 为0 置灰， 收益率 计算可得
        NSArray *platformList = @[@{@"platform":@"支付宝",@"id":@1,@"total":@0,@"earnings":@0},
                                  @{@"platform":@"腾讯理财通",@"id":@2,@"total":@0,@"earnings":@0},
                                  @{@"platform":@"京东金融",@"id":@3,@"total":@0,@"earnings":@0},
                                  @{@"platform":@"理财魔方",@"id":@4,@"total":@0,@"earnings":@0},
                                  @{@"platform":@"谱蓝",@"id":@5,@"total":@0,@"earnings":@0},
                                  @{@"platform":@"天天基金",@"id":@6,@"total":@0,@"earnings":@0},
                                  @{@"platform":@"掌上基金",@"id":@7,@"total":@0,@"earnings":@0},
                                  @{@"platform":@"玖富",@"id":@8,@"total":@0,@"earnings":@0},
                                  @{@"platform":@"拍拍贷",@"id":@9,@"total":@0,@"earnings":@0},
                                  @{@"platform":@"人人贷",@"id":@10,@"total":@0,@"earnings":@0},
                                  @{@"platform":@"爱钱进",@"id":@11,@"total":@0,@"earnings":@0},
                                  @{@"platform":@"51人品",@"id":@12,@"total":@0,@"earnings":@0},
                                  @{@"platform":@"口袋理财",@"id":@13,@"total":@0,@"earnings":@0},
                                  @{@"platform":@"口袋记账",@"id":@14,@"total":@0,@"earnings":@0},
                                  @{@"platform":@"PPmoney",@"id":@15,@"total":@0,@"earnings":@0},
                                  @{@"platform":@"拿铁智投",@"id":@16,@"total":@0,@"earnings":@0},
                                  @{@"platform":@"积木盒子",@"id":@17,@"total":@0,@"earnings":@0},
                                  @{@"platform":@"你我贷",@"id":@18,@"total":@0,@"earnings":@0},
                                  @{@"platform":@"点融",@"id":@19,@"total":@0,@"earnings":@0}];
        
        NSMutableArray *tmpArr = [NSMutableArray arrayWithCapacity:platformList.count];
        for (NSDictionary *dict in platformList) {
            PlatformModel *model = [[PlatformModel alloc] initWithDictionary:dict];
            [tmpArr addObject:model];
        }
        
        [[TMCache sharedCache] setObject:tmpArr.copy forKey:PlatformInfoTableKey];
    }
}

@end
